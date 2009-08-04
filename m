From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 13906] New: Huawei E169 GPRS connection causes
 Ooops
Date: Tue, 4 Aug 2009 02:16:37 -0700
Message-ID: <20090804021637.ce7e62ad.akpm@linux-foundation.org>
References: <bug-13906-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42533 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932527AbZHDJRK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Aug 2009 05:17:10 -0400
In-Reply-To: <bug-13906-10286@http.bugzilla.kernel.org/>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-usb@vger.kernel.org, Greg KH <greg@kroah.com>, linux-serial@vger.kernel.org
Cc: bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, Clemens Eisserer <linuxhippy@gmail.com>


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Tue, 4 Aug 2009 09:02:16 GMT bugzilla-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=13906
> 
>            Summary: Huawei E169 GPRS connection causes Ooops
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 2.6.31.rc5
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Serial
>         AssignedTo: rmk@arm.linux.org.uk
>         ReportedBy: linuxhippy@gmail.com
>         Regression: No
> 

use-after-free in the tty/serial code, I expect.

I also expect that it's a regression - Clemens, are you able to say
whether any earlier kernel version worked OK?

Thanks.

> I am using umtsmon to connect my Huawei-E169 to Internet.
> 
> When connecting to an UMTS network everything works fine, however when
> connecting to a GPRS network (fallback, if no umts network available), I get
> the following Ooops:
> 
> PPP generic driver version 2.4.2                                                
> PPP Deflate Compression module registered                                       
> BUG: unable to handle kernel paging request at 6b6b6b87                         
> IP: [<f7cc3df9>] serial_do_free+0x30/0x7b [usbserial]                           
> *pde = 00000000                                                                 
> Oops: 0000 [#1] SMP                                                             
> last sysfs file:
> /sys/devices/pci0000:00/0000:00:1c.2/0000:02:00.0/ieee80211/phy0/rfkill1/uevent 
> Modules linked in: ppp_deflate zlib_deflate ppp_async crc_ccitt ppp_generic
> slhc fuse option usbserial usb_storage sunrpc ipv6 cpufreq_ondemand
> acpi_cpufreq dm_multipath uinput snd_hda_codec_si3054 snd_hda_codec_realtek
> snd_hda_intel snd_hda_codec snd_hwdep snd_pcm arc4 ppdev btusb parport_pc ecb
> bluetooth firewire_ohci firewire_core iwl3945 sdhci_pci yenta_socket snd_timer
> iTCO_wdt sdhci snd parport rsrc_nonstatic crc_itu_t iTCO_vendor_support iwlcore
> mmc_core soundcore snd_page_alloc e1000e mac80211 toshiba_acpi cfg80211 joydev
> rfkill ata_generic pata_acpi i915 drm i2c_algo_bit i2c_core video output [last
> unloaded: microcode]
> 
> Pid: 1472, comm: umtsmon Not tainted (2.6.31-0.118.rc5.fc12.i686 #1) Tecra A8
> EIP: 0060:[<f7cc3df9>] EFLAGS: 00010286 CPU: 0
> EIP is at serial_do_free+0x30/0x7b [usbserial]
> EAX: f259ca6c EBX: f63eca50 ECX: f7cc3e44 EDX: 6b6b6b6b
> ESI: f63eca88 EDI: 00000000 EBP: f15d3e84 ESP: f15d3e74
>  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
> Process umtsmon (pid: 1472, ti=f15d2000 task=f1602b80 task.ti=f15d2000)
> Stack:
>  ed87ae0e f259c860 f25872a0 00000000 f15d3ea0 f7cc3ed3 f15cc900 ed87ae0e
> <0> f25872a0 00000000 00000000 f15d3f34 c0679747 f15d3ee4 f25960b0 00000000
> <0> 00000000 ed87ae0e 00000000 ed87ae0e f15d3ee4 c046ec0c 00000000 00000000
> Call Trace:
>  [<f7cc3ed3>] ? serial_close+0x8f/0xa8 [usbserial]
>  [<c0679747>] ? tty_release_dev+0x16a/0x3fa
>  [<c046ec0c>] ? mark_lock+0x29/0x1f6
>  [<c045c7ba>] ? autoremove_wake_function+0x0/0x55
>  [<c04f524a>] ? sys_close+0x35/0xc2
>  [<c06799fc>] ? tty_release+0x25/0x41
>  [<c04f8a42>] ? __fput+0x101/0x1a2
>  [<c04f8b0a>] ? fput+0x27/0x3a
>  [<c04f51fa>] ? filp_close+0x64/0x7f
>  [<c04f5291>] ? sys_close+0x7c/0xc2
>  [<c0403a50>] ? syscall_call+0x7/0xb
> Code: 53 83 ec 04 0f 1f 44 00 00 65 8b 15 14 00 00 00 89 55 f0 31 d2 80 b8 06
> 02 00 00 00 75 41 8b 18 05 0c 02 00 00 8b 53 04 8d 73 38 <8b> 7a 1c e8 14 03 9e
> c8 31 d2 89 f0 e8 54 80 b5 c8 f6 43 0c 01
> EIP: [<f7cc3df9>] serial_do_free+0x30/0x7b [usbserial] SS:ESP 0068:f15d3e74
> CR2: 000000006b6b6b87
> ---[ end trace 6c0877bfb04cdcd3 ]---

