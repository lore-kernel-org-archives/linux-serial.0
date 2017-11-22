From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [serial8250_interrupt] RIP: 0010:arch_local_irq_restore+0x2/0x8
Date: Thu, 23 Nov 2017 07:36:23 +0800
Message-ID: <20171122233623.7ud3wvtuemfvl3t3@wfg-t540p.sh.intel.com>
References: <20171121090529.p3bcdz5y5bs5mqk2@wfg-t540p.sh.intel.com>
 <20171121123357.bw5raz3vqkob2vgz@wfg-t540p.sh.intel.com>
 <20171121133120.43fe5ak2gct56nmp@wfg-t540p.sh.intel.com>
 <1511275154.25007.349.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1511275154.25007.349.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Sean Young <sean@mess.org>, Matthias Brugger <mbrugger@suse.com>, linux-kernel@vger.kernel.org, lkp@01.org
List-Id: linux-serial@vger.kernel.org

On Tue, Nov 21, 2017 at 04:39:14PM +0200, Andy Shevchenko wrote:
>On Tue, 2017-11-21 at 21:31 +0800, Fengguang Wu wrote:
>> On Tue, Nov 21, 2017 at 08:33:57PM +0800, Fengguang Wu wrote:
>> > Hello,
>> >
>> > FYI this happens in mainline kernel 4.14.0-02748-gabc36be.
>> > It shows up since v4.13 .
>>
>> Sorry it actually also shows up in 4.10:
>
>This one means that interrupt storm is occurred. Last time I saw that
>was by the fact of some specific IOAPIC configuration when DMA for UART
>was enabled.
>
>I'm pretty sure that is not the case here. Though, it would be nice to
>see link to the following files:

It's basically a KVM machine. This is adapted from the reproduce
script attached in the first email: 

kvm=(
        qemu-system-x86_64
        -enable-kvm
        -cpu IvyBridge
        -kernel $kernel
        -initrd initrd.img
        -m 1536
        -smp 2
        -device e1000,netdev=net0
        -netdev user,id=net0,hostfwd=tcp::23406-:22
        -boot order=nc
        -no-reboot
        -watchdog i6300esb
        -watchdog-action debug
        -rtc base=localtime
        -drive file=disk-vm-ivb41-1G-7-0,media=disk,if=virtio
        -drive file=disk-vm-ivb41-1G-7-1,media=disk,if=virtio
        -drive file=disk-vm-ivb41-1G-7-2,media=disk,if=virtio
        -drive file=disk-vm-ivb41-1G-7-3,media=disk,if=virtio
        -drive file=disk-vm-ivb41-1G-7-4,media=disk,if=virtio
        -drive file=disk-vm-ivb41-1G-7-5,media=disk,if=virtio
        -serial stdio
        -display none
        -monitor null
)

append=(
        ip=::::vm-ivb41-1G-7::dhcp
        root=/dev/ram0
        user=lkp
        job=/job-script
        ARCH=x86_64
        kconfig=x86_64-allyesdebian
        branch=linus/master
        commit=abc36be236358162202e86ad88616ff95a755101
        BOOT_IMAGE=/pkg/linux/x86_64-allyesdebian/gcc-6/abc36be236358162202e86ad88616ff95a755101/vmlinuz-4.14.0-02748-gabc36be
        max_uptime=600
        RESULT_ROOT=/result/boot/1/vm-ivb41-1G/debian-x86_64-2016-08-31.cgz/x86_64-allyesdebian/gcc-6/abc36be236358162202e86ad88616ff95a755101/0
        result_service=tmpfs
        debug
        apic=debug
        sysrq_always_enabled
        rcupdate.rcu_cpu_stall_timeout=100
        net.ifnames=0
        printk.devkmsg=on
        panic=-1
        softlockup_panic=1
        nmi_watchdog=panic
        oops=panic
        load_ramdisk=2
        prompt_ramdisk=0
        drbd.minor_count=8
        systemd.log_level=err
        ignore_loglevel
        console=tty0
        earlyprintk=ttyS0,115200
        console=ttyS0,115200
        vga=normal
        rw
)

Thanks,
Fengguang
