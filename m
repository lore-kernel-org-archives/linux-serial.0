From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [serial: 8250_lpss] a13e19cf3d: BUG: kernel hang in boot stage
Date: Mon, 24 Oct 2016 10:13:53 +0800
Message-ID: <20161024021353.ij63ldkfl7cigcwr@wfg-t540p.sh.intel.com>
References: <57ca88ec.8Uwmgj9cHsfC4q6Q%fengguang.wu@intel.com>
 <1473088503.11323.8.camel@linux.intel.com>
 <1477154414.6423.34.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477154414.6423.34.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, LKP <lkp@01.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Hi Andy,

On Sat, Oct 22, 2016 at 07:40:14PM +0300, Andy Shevchenko wrote:
>On Mon, 2016-09-05 at 18:15 +0300, Andy Shevchenko wrote:
>> +Heikki
>>
>> On Sat, 2016-09-03 at 16:25 +0800, kernel test robot wrote:
>> > Greetings,
>> >
>> > 0day kernel testing robot got the below dmesg and the first bad
>> > commit
>> > is
>>
>> Briefly tested I have hang issues *with* or *without* the mentioned
>> commit if under hang you meant no getty available on serial console.
>> Otherwise I see output from kernel till 
>>
>> [   61.625900] raid6test: complete (2429 tests, 0 failures)
>> [   61.671165] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
>> [   61.678004] EDD information not available.
>> [   61.714036] ALSA device list:
>> [   61.717459]   #0: Dummy 1
>> [   61.720480]   #1: MTPAV on parallel port at 0x378
>>
>> Attached defconfigs per commit I have tested (also diff between mine
>> and
>> yours when I did make savedefconfig).
>>
>> So, may I ask what exact hardware you are using to test this one?
>
>May I ask beloved LKP team what the status of the issue is? Shall we
>close it or there is more information coming?

Please close the issue.

I tried rebuild the kernel and redo the tests, and find the new kernel
no longer has early boot hang. Sorry for the noise!

Cheers,
Fengguang

>> >
>> > https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-
>> > next
>> >
>> > commit a13e19cf3dc1080cf8a3a174cefd9199610faed7
>> > Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> > AuthorDate: Wed Aug 17 19:20:27 2016 +0300
>> > Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > CommitDate: Wed Aug 31 16:13:30 2016 +0200
>> >
>> >     serial: 8250_lpss: split LPSS driver to separate module
>> >     
>> >     The SoCs, such as Intel Braswell, have DesignWare UART IP. Split
>> > out the
>> >     support of such chips to a separate module which also will be
>> > used
>> > for Intel
>> >     Quark later.
>> >     
>> >     The rationale to have the separate driver to be existing:
>> >     - Do not contaminate 8250_pci.c anymore with LPSS related quirks
>> >     - All of them are using same DMA engine and they are Designware
>> > IP
>> > which means
>> >       that in the future we might share the code between 8250_dw.c
>> > and
>> > 8250_lpss.c
>> >     - It reduces the kernel memory footprint on non-X86 machines
>> > where
>> > 8250_pci.c
>> >       is in use
>> >     
>> >     Besides the split the driver also has been refactored, in
>> > particular a) the DMA
>> >     and port setup are separate functions, b) the two new structures
>> > lpss8250 and
>> >     lpss8250_board are introduced to keep necessary data instead of
>> >     pciserial_board, c) DMA parameters are passed to the DMA setup
>> > via
>> > mentioned
>> >     custom structure. Most of the changes are done due to the future
>> > support of
>> >     UART DMA on Intel Quark.
>> >     
>> >     The Intel Quark UART DMA support is based on bits taking from
>> > BSP
>> > code
>> >     published by Intel earlier.
>> >     
>> >     The driver does not use any specific power management. PCI core
>> > takes care of
>> >     the default behaviour during suspend and resume.
>> >     
>> >     Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.co
>> > m>
>> >     Tested-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
>> >     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> >
>> > +-------------------------------+------------+------------+---------
>> > --
>> > -+
>> > >
>> > >                               | 68af490b03 | a13e19cf3d |
>> > > 6fe4da5401
>> > > >
>> >
>> > +-------------------------------+------------+------------+---------
>> > --
>> > -+
>> > >
>> > > boot_successes                | 63         | 0          |
>> > > 0          |
>> > > boot_failures                 | 0          | 26         |
>> > > 27         |
>> > > BUG:kernel_hang_in_boot_stage | 0          | 26         |
>> > > 27         |
>> >
>> > +-------------------------------+------------+------------+---------
>> > --
>> > -+
>> >
>> > Booting the kernel.
>> >
>> > Elapsed time: 500
>> > BUG: kernel hang in boot stage
>> > Linux version 4.8.0-rc2-00028-ga13e19c #1
>> > Command line:  root=/dev/ram0 hung_task_panic=1 debug apic=debug
>> > sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100
>> > net.ifnames=0
>> > printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic
>> > oops=panic load_ramdisk=2 prompt_ramdisk=0 systemd.log_level=err
>> > ignore_loglevel earlyprintk=ttyS0,115200 console=ttyS0,115200
>> > console=tty0 vga=normal rw link=/kbuild-tests/run-queue/kvm/x86_64-
>> > randconfig-r0-09031101/linux-devel:devel-spot-
>> > 201609030826:a13e19cf3dc1080cf8a3a174cefd9199610faed7:bisect-linux-
>> > 0/.vmlinuz-a13e19cf3dc1080cf8a3a174cefd9199610faed7-20160903152912-
>> > 8-
>> > vp branch=linux-devel/devel-spot-201609030826
>> > BOOT_IMAGE=/pkg/linux/x86_64-randconfig-r0-09031101/gcc-
>> > 6/a13e19cf3dc1080cf8a3a174cefd9199610faed7/vmlinuz-4.8.0-rc2-00028-
>> > ga13e19c drbd.minor_count=8
>> >
>> >
>> > git bisect start 6fe4da54019254083959652e61fab5d7b6d8b16b
>> > 3eab887a55424fc2c27553b7bfe32330df83f7b8 --
>> > git bisect good 86374892625f368ff0a7d0045bbd10f5005f5095  #
>> > 13:00     20+      0  Merge 'linux-review/Paul-Burton/Partial-MIPS-
>> > Malta-DT-conversion/20160903-000153' into devel-spot-201609030826
>> > git bisect  bad 28b0a3136795a9a1d1abb0331790bbae75e71e03  #
>> > 13:14      0-     11  Merge 'renesas/topic/sdr104-v6' into devel-
>> > spot-
>> > 201609030826
>> > git bisect good 2e5ad9bf16a597bcf52ffee14dc5a3dc80e60ae9  #
>> > 13:24     22+      0  Merge 'linux-review/Wang-Nan/perf-report-
>> > Recognize-hugetlb-mapping-as-anon-mapping/20160902-220432' into
>> > devel-
>> > spot-201609030826
>> > git bisect  bad bedfbf8942db947f2a9be3e3a4e01d8ddf3bdf4e  #
>> > 13:40      0-      8  Merge 'linux-review/Luca-Ceresoli/rtl8723au-
>> > remove-declaration-of-unimplemented-functions/20160902-211231' into
>> > devel-spot-201609030826
>> > git bisect  bad 687a5fb1c4382d1e37d444fdc24f9a0ecb4034a0  #
>> > 14:02      0-     10  Merge 'tty/tty-testing' into devel-spot-
>> > 201609030826
>> > git bisect good 259bbca0cd7b626ab0fc5eb63dfc24b1408e29b4  #
>> > 14:13     21+      0  Merge 'linux-review/Toke-H-iland-J-
>> > rgensen/mac80211-Move-reorder-sensitive-TX-handlers-to-after-TXQ-
>> > dequeue/20160902-215155' into devel-spot-201609030826
>> > git bisect good bf7a791d2c931375ae966adfb0a93eae426c6d7e  #
>> > 14:26     22+      0  Merge 'linux-review/Hariprasad-Shenai/cxgb4-
>> > Add-
>> > support-for-ndo_get_vf_config/20160902-214923' into devel-spot-
>> > 201609030826
>> > git bisect good 5887ad43ee02a00f17a6132b7fb256dc6865474c  #
>> > 14:41     22+      0  tty: serial: fsl_lpuart: Use cyclic DMA for Rx
>> > git bisect good 9217a5bf66061c392e461255c5d9d41aac136e58  #
>> > 14:50     22+      0  dmaengine: dw: keep copy of custom slave
>> > config
>> > in dwc
>> > git bisect good 8d17047207d52182ccd55b9529e1c8cc062c07c2  #
>> > 15:06     22+      0  serial: 8250_dma: switch to new
>> > dmaengine_terminate_* API
>> > git bisect good 68af490b03b40cc31b2cd47899661d87ab9f127d  #
>> > 15:22     22+      0  serial: 8250: enable AFE on ports where FIFO
>> > is
>> > 16 bytes
>> > git bisect  bad a13e19cf3dc1080cf8a3a174cefd9199610faed7  #
>> > 15:36      0-      4  serial: 8250_lpss: split LPSS driver to
>> > separate
>> > module
>> > # first bad commit: [a13e19cf3dc1080cf8a3a174cefd9199610faed7]
>> > serial:
>> > 8250_lpss: split LPSS driver to separate module
>> > git bisect good 68af490b03b40cc31b2cd47899661d87ab9f127d  #
>> > 15:40     63+      0  serial: 8250: enable AFE on ports where FIFO
>> > is
>> > 16 bytes
>> > # extra tests on HEAD of linux-devel/devel-spot-201609030826
>> > git bisect  bad 6fe4da54019254083959652e61fab5d7b6d8b16b  #
>> > 15:40      0-     27  0day head guard for 'devel-spot-201609030826'
>> > # extra tests on tree/branch tty/tty-next
>> > git bisect  bad d2f5a7311bcaed681a41cb3419b8fe92a7b68bf5  #
>> > 16:00      0-     17  dmaengine: hsu: refactor hsu_dma_do_irq() to
>> > return int
>> > # extra tests on tree/branch linus/master
>> > git bisect good 0141af184adc7f6ea9bd2f9631a15704d0806f8b  #
>> > 16:10     66+      1  Merge branch 'for-linus' of
>> > git://git.kernel.dk/linux-block
>> > # extra tests on tree/branch linux-next/master
>> > git bisect good 0f98f121e1670eaa2a2fbb675e07d6ba7f0e146f  #
>> > 16:24     65+      1  Add linux-next specific files for 20160825
>> >
>> >
>> > ---
>> > 0-DAY kernel test infrastructure                Open Source
>> > Technology
>> > Center
>> > https://lists.01.org/pipermail/lkp                          Intel
>> > Corporation
>>
>>
>
>-- 
>Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>Intel Finland Oy
