# Disk Partitioning and LVM Configuration Guide

Configure a 15GB disk with multiple partitions and LVM management for a Linux system.

---

## **Final Structure**
```
sda
├─sda1 (5GB) → /data (ext4/xfs)
├─sda2 (5GB) → vg01/lv01 (ext4/xfs)
├─sda3 (3GB) → Extended to vg01/lv01
└─sda4 (2GB) → swap
```

---

## **Step-by-Step Implementation**

### 1. Prepare Disk
Identify new disk:
```bash
lsblk
```
(Assume disk is `/dev/sda`)

### 2. Create Partitions
```bash
sudo parted /dev/sda
```
Partition scheme:
```
mklabel gpt
mkpart primary 0% 5GB
mkpart primary 5GB 10GB
mkpart primary 10GB 13GB
mkpart primary 13GB 15GB
set 1 lvm on
set 2 lvm on
set 4 swap on
print
quit
```

### 3. Create Filesystems
```bash
# 5GB Filesystem
sudo mkfs.ext4 /dev/sda1  # or xfs

# Swap
sudo mkswap /dev/sda4
sudo swapon /dev/sda4

# LVM Setup
sudo pvcreate /dev/sda2
sudo vgcreate vg01 /dev/sda2
sudo lvcreate -n lv01 -l 100%FREE vg01
sudo mkfs.ext4 /dev/vg01/lv01  # or xfs
```

### 4. Extend LVM
```bash
sudo pvcreate /dev/sda3
sudo vgextend vg01 /dev/sda3
sudo lvextend -l +100%FREE /dev/vg01/lv01
sudo resize2fs /dev/vg01/lv01  # or xfs_growfs
```

### 5. Mount Points
```bash
# Permanent mounts
echo '/dev/sda1  /mnt/data  ext4  defaults 0 0' | sudo tee -a /etc/fstab
echo '/dev/vg01/lv01  /mnt/lvm_data  ext4  defaults 0 0' | sudo tee -a /etc/fstab
echo '/dev/sda4  none  swap  sw  0 0' | sudo tee -a /etc/fstab

# Create directories and mount
sudo mkdir -p /mnt/{data,lvm_data}
sudo mount -a
```

---

## **Verification Commands**
```bash
# Partition verification
lsblk -f /dev/sda

# Swap verification
swapon --show

# LVM verification
sudo pvs
sudo vgs
sudo lvs
```

---

## **Customization Options**
1. **Filesystem Choice**: Replace `ext4` with `xfs`
2. **Mount Points**: Change `/mnt/data` and `/mnt/lvm_data`
3. **LVM Configuration**:
   - Different PE sizes: `-s 32M` in `vgcreate`
   - Thin provisioning: `lvcreate -T`

---

## **Troubleshooting**
**Common Issues**:
- "Device not found": Rescan storage `echo 1 > /sys/block/sda/device/rescan`
- LVM detection: `vgscan` and `vgchange -ay`
- Filesystem resize: Ensure unmounted for xfs (`xfs_repair`)

---

## **Important Notes**
1. **Data Loss Warning**: All operations are destructive
2. **Persistent Configuration**: Required fstab entries
3. **Capacity Planning**: Verify with `df -h` and `free -h`
4. **Backup**: Critical before partitioning operations

---

## **Security Considerations**
1. **Permissions**: Set proper mountpoint permissions
2. **Swap Encryption**: Consider encrypted swap for sensitive data
3. **LVM Security**: Use `lvmlockd` for shared storage

---

**Next Steps**: Consider implementing RAID or LVM caching for improved performance.