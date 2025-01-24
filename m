Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5B616191B
	for <linux-serial@vger.kernel.org>; Fri, 24 Jan 2025 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737735018; cv=none; b=NSsVwrsjPsmHTQJVqvcAkZApNyv8iuw+oW924rPcufocNTPqKuxE+776iyuQKisdFMxdA0G7zyBRGZPdsxy20FqKhGsu9GHpAkJAFsrpte6DIKiNFjNTsiWmetnWLgoAyd9j9+pfs8bciUjwgSgNpMR6gurOMstWAQjv7GBppNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737735018; c=relaxed/simple;
	bh=suO/Hk4j/zrncto0MA7AcasZQN9F4IU1ct3sMYrvzb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4tBlp2v58tEg/x+g3JZXUx0+lVla8w7x7QTIvS1/Zu6p8CCWBxXPLaAe4vx4+W9Tk1wyKh6egv+AKNCrZwIjAvKhxhUJ7D0uh1ZZcPgSWvfW9annxSHQDi9MB2yi1whATFze/EMS1QlISJpM2iC/mvFLL4q5j+6XVmTgFXyMc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aycbUVMn; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aycbUVMn"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436345cc17bso16712275e9.0
        for <linux-serial@vger.kernel.org>; Fri, 24 Jan 2025 08:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737735014; x=1738339814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A7FNuEvrxRERO/DjO33+5NS5pQWzC0ELF/HvARceHOg=;
        b=aycbUVMnUclAoaD2P9ZYzEttOx/XVq3h4tSaan1RGFOcVjfSuz6YSnJRVZixFl7eWQ
         K3NhJh6cVsciXYGH+PO0X7YX0Wq4bYrdeNxHC1Sl8bnHKyy5QK4S5wIBEuZP+3n/GnFJ
         R5p7nGM9EZM0OGF5McZZpLqC2XhCtGlbStGPk5qF62WD0FdU06Ww6MsdbMcxs2Y7sHgI
         s69TffmO5wteDn5Xr0rO5Uo3oc3PQgqWQkbVuuQe/7MrDUIq/MFs57Cy/OCQNyu2XWE6
         5kKd+GsrOxinm/L1dUqF78+t0/aQmbfdMPEkBz/M3E3iF4NY+RT8GxzqIU57WWrFEfk7
         LNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737735014; x=1738339814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7FNuEvrxRERO/DjO33+5NS5pQWzC0ELF/HvARceHOg=;
        b=pO2oYnPBibObSE9YiRTphdxt1Aoze4Zv7676lTvXchWfZbOzw+rvUFxCIaZMpohMdI
         JzZZRjlwrCmkVrwBzJ1uhEpeJ1cEqH4qBYgzQuk9JJSYY/Xy3prkL4GgYm+IQtC1+q3R
         8B1ZqU1i9AWldZou/DRWHHe+8Q22pSK2hJBWD61dzgs04Z8hTEyieLE4opE9u0DbJBXE
         ABxx3LphXserw3YWl1nhjuro1DFjxio+3IQz4KeL7s3/wRk/orUAPvAxyubuWUbA0HUi
         nIA51nsWzbxDO5cm4zDkpF3+Ofk+u4JoMvwPvcKnHFpZwDC4u4Wb3y4VefKeTszKWrj5
         4ZgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVO+XkgRd5/ldndsO0qneN7BO6iAs9fBZnx8ZA8eSxO8fmLgDOjVeYBZJv86fiFJ4Bmt4kn4CQIev3hlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZDU4Z8Fwo9Rts588JQg2o4kWR2gWz0us8/N1nfUalmKwnlWjI
	mQtBtV+W0m9SOqC1PVSeVx8/g6w5B8JYEOjQTICCudAT3xQfQX5S25DcD8pxB28=
X-Gm-Gg: ASbGncswYNDiC7z194SKXa9wqs4Zz5xU+0SVpGAFz4WIneanFesAW2BF9IGLGGXH1Ns
	+NCE4MkNwuqolNJVC2I9Zqs5737wc7SB3hjQfHkqaD5uitW0dkR6g3DNFbXSIrJW26jVzbvPGF1
	Wnhz4xa5LTSH2POutOj6T1ZN/BKJPJwMofGV+4ErCk2mO7GCCHmLH4WFXL28j3zaBEbjpoq76Gf
	q7IJ2FvZh3XZ0oZBh1DILD7F1BefbbhnaFXOiAW/5ncKGGUc/PnBexKb+AYOUtIYZSrfd0TnTq5
	CPjMGEU=
X-Google-Smtp-Source: AGHT+IF6IfqCD/eRkN5otYUADSiqh35IJ5nA4lZEaD+0/hPYzy6blVlJ4IAvTg0x+HC5Ki8uTEKz2g==
X-Received: by 2002:a05:600c:46c5:b0:434:a4b3:5ebe with SMTP id 5b1f17b1804b1-438914297c0mr283125455e9.24.1737735013602;
        Fri, 24 Jan 2025 08:10:13 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4b9984sm31356145e9.28.2025.01.24.08.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 08:10:13 -0800 (PST)
Date: Fri, 24 Jan 2025 17:10:11 +0100
From: Petr Mladek <pmladek@suse.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: John Ogness <john.ogness@linutronix.de>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [linux-next:master] [serial]  b63e6f60ea:
 BUG:soft_lockup-CPU##stuck_for#s![modprobe:#]
Message-ID: <Z5O7Y_tdtvOahjRs@pathway.suse.cz>
References: <202501221029.fb0d574d-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202501221029.fb0d574d-lkp@intel.com>

Hi,

I am Jason into Cc. I wonder if the softlockup might be caused
by a lack of entropy.

On Wed 2025-01-22 10:28:52, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:soft_lockup-CPU##stuck_for#s![modprobe:#]" on:
> 
> commit: b63e6f60eab45b16a1bf734fef9035a4c4187cd5 ("serial: 8250: Switch to nbcon console")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master 0907e7fb35756464aa34c35d6abb02998418164b]
> 
> in testcase: kunit
> version: 
> with following parameters:
> 
> 	group: group-01
> 
> 
> 
> config: x86_64-rhel-9.4-kunit
> compiler: gcc-12
> test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 16G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202501221029.fb0d574d-lkp@intel.com
> 
> 
> [  231.759560][    C3] watchdog: BUG: soft lockup - CPU#3 stuck for 26s! [modprobe:3860]
> [  231.759572][    C3] Modules linked in: test_rslib(+) reed_solomon ipmi_devintf ipmi_msghandler intel_rapl_msr intel_rapl_common btrfs snd_hda_codec_hdmi x86_pkg_temp_thermal intel_powerclamp blake2b_generic coretemp xor raid6_pq libcrc32c kvm_intel snd_hda_codec_realtek snd_hda_codec_generic platform_profile i915 kvm snd_hda_scodec_component snd_hda_intel sd_mod snd_intel_dspcfg dell_wmi crc32_generic snd_intel_sdw_acpi sg crct10dif_pclmul cec crc32_pclmul dell_smbios snd_hda_codec intel_gtt crc32c_intel dell_wmi_descriptor ghash_clmulni_intel sparse_keymap snd_hda_core ttm snd_hwdep ahci rapl rfkill drm_display_helper snd_pcm mei_wdt libahci intel_cstate dcdbas snd_timer mei_me libata intel_uncore drm_kms_helper snd pcspkr drm_buddy mei soundcore video wmi binfmt_misc drm fuse loop dm_mod ip_tables poly1305_generic chacha_generic [last unloaded: test_fpu]
> [  231.759681][    C3] CPU: 3 UID: 0 PID: 3860 Comm: modprobe Tainted: G S  B            N 6.13.0-rc3-00034-gb63e6f60eab4 #1
> [  231.759690][    C3] Tainted: [S]=CPU_OUT_OF_SPEC, [B]=BAD_PAGE, [N]=TEST
> [  231.759694][    C3] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
> [ 231.759699][ C3] RIP: 0010:encode_rs16 (lib/reed_solomon/encode_rs.c:33) reed_solomon 
> [ 231.759708][ C3] Code: 87 68 83 00 00 89 da d3 fa 41 0f b6 4d 00 41 38 cc 7c 08 84 c9 0f 85 64 02 00 00 8b 75 04 21 f3 01 d3 39 de 7e c0 48 8b 3c 24 <48> 63 db 48 8d 1c 5f 48 89 d9 48 c1 e9 03 42 0f b6 34 39 48 89 d9
> All code
> ========
>    0:	87 68 83             	xchg   %ebp,-0x7d(%rax)
>    3:	00 00                	add    %al,(%rax)
>    5:	89 da                	mov    %ebx,%edx
>    7:	d3 fa                	sar    %cl,%edx
>    9:	41 0f b6 4d 00       	movzbl 0x0(%r13),%ecx
>    e:	41 38 cc             	cmp    %cl,%r12b
>   11:	7c 08                	jl     0x1b
>   13:	84 c9                	test   %cl,%cl
>   15:	0f 85 64 02 00 00    	jne    0x27f
>   1b:	8b 75 04             	mov    0x4(%rbp),%esi
>   1e:	21 f3                	and    %esi,%ebx
>   20:	01 d3                	add    %edx,%ebx
>   22:	39 de                	cmp    %ebx,%esi
>   24:	7e c0                	jle    0xffffffffffffffe6
>   26:	48 8b 3c 24          	mov    (%rsp),%rdi
>   2a:*	48 63 db             	movslq %ebx,%rbx		<-- trapping instruction
>   2d:	48 8d 1c 5f          	lea    (%rdi,%rbx,2),%rbx
>   31:	48 89 d9             	mov    %rbx,%rcx
>   34:	48 c1 e9 03          	shr    $0x3,%rcx
>   38:	42 0f b6 34 39       	movzbl (%rcx,%r15,1),%esi
>   3d:	48 89 d9             	mov    %rbx,%rcx
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	48 63 db             	movslq %ebx,%rbx
>    3:	48 8d 1c 5f          	lea    (%rdi,%rbx,2),%rbx
>    7:	48 89 d9             	mov    %rbx,%rcx
>    a:	48 c1 e9 03          	shr    $0x3,%rcx
>    e:	42 0f b6 34 39       	movzbl (%rcx,%r15,1),%esi
>   13:	48 89 d9             	mov    %rbx,%rcx
> [  231.759717][    C3] RSP: 0018:ffffc90000abf3b0 EFLAGS: 00000297
> [  231.759723][    C3] RAX: ffff888102c9ff0a RBX: 00000000000000dd RCX: 0000000000000000
> [  231.759728][    C3] RDX: 0000000000000000 RSI: 00000000000000ff RDI: ffff88816b6b7c00
> [  231.759733][    C3] RBP: ffff88812901fb00 R08: 00000000000000c8 R09: ffff88816c8b518e
> [  231.759738][    C3] R10: 1ffff11025203f60 R11: ffff88816c8b5184 R12: 0000000000000007
> [  231.759743][    C3] R13: ffffed1025203f60 R14: ffffed1025203f60 R15: dffffc0000000000
> [  231.759748][    C3] FS:  00007f64c760f040(0000) GS:ffff8883a7d80000(0000) knlGS:0000000000000000
> [  231.759754][    C3] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  231.759759][    C3] CR2: 00007f024b693000 CR3: 00000001d4462004 CR4: 00000000001726f0
> [  231.759764][    C3] DR0: ffffffff8789050c DR1: ffffffff8789050d DR2: ffffffff8789050e
> [  231.759769][    C3] DR3: ffffffff8789050f DR6: 00000000fffe0ff0 DR7: 0000000000000600
> [  231.759774][    C3] Call Trace:
> [  231.759778][    C3]  <IRQ>
> [ 231.759782][ C3] ? watchdog_timer_fn (kernel/watchdog.c:770) 
> [ 231.759790][ C3] ? __pfx_watchdog_timer_fn (kernel/watchdog.c:685) 
> [ 231.759796][ C3] ? __hrtimer_run_queues (kernel/time/hrtimer.c:1739 kernel/time/hrtimer.c:1803) 
> [ 231.759803][ C3] ? __pfx___hrtimer_run_queues (kernel/time/hrtimer.c:1773) 
> [ 231.759808][ C3] ? ktime_get_update_offsets_now (kernel/time/timekeeping.c:312 (discriminator 3) kernel/time/timekeeping.c:335 (discriminator 3) kernel/time/timekeeping.c:2457 (discriminator 3)) 
> [ 231.759814][ C3] ? sched_clock (arch/x86/include/asm/preempt.h:94 arch/x86/kernel/tsc.c:286) 
> [ 231.759821][ C3] ? hrtimer_interrupt (kernel/time/hrtimer.c:1868) 
> [ 231.759828][ C3] ? __sysvec_apic_timer_interrupt (arch/x86/include/asm/jump_label.h:36 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1056) 
> [ 231.759835][ C3] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1049 arch/x86/kernel/apic/apic.c:1049) 
> [  231.759842][    C3]  </IRQ>
> [  231.759845][    C3]  <TASK>
> [ 231.759848][ C3] ? asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
> [ 231.759857][ C3] ? encode_rs16 (lib/reed_solomon/encode_rs.c:33) reed_solomon 
> [ 231.759864][ C3] get_rcw_we (lib/reed_solomon/test_rslib.c:173) test_rslib 

Honestly, I do not see much how this could be related to the serial
console. This is a module for testing the Generic Reed Solomon
encoder / decoder library.

It seems to do a lot of computation and needs a lot of random numbers.
I wonder if there is not enough entropy and the test is too slow.

From the config file:

CONFIG_PREEMPT_VOLUNTARY=y

I wonder if a cond_resched() in some loop would help. Or using a
pseudorandom generator. I remember the problems related to much
slower random generator, for example, see the commit f900fde28883602b6
("crypto: testmgr - fix RNG performance in fuzz tests").

That said, I did not dig deep into the code. And I did not try to
reproduce the softlockup. I am pretty busy at the moment with some
other stuff. I just wanted to give it a look and share my opinion.

Best Regards,
Petr


> [ 231.759873][ C3] test_bc (lib/reed_solomon/test_rslib.c:379) test_rslib 
> [ 231.759880][ C3] ? run_exercise (lib/reed_solomon/test_rslib.c:127 lib/reed_solomon/test_rslib.c:457) test_rslib 
> [ 231.759886][ C3] run_exercise (lib/reed_solomon/test_rslib.c:423 lib/reed_solomon/test_rslib.c:477) test_rslib 
> [ 231.759895][ C3] ? __pfx_run_exercise (lib/reed_solomon/test_rslib.c:443) test_rslib 
> [ 231.759902][ C3] test_rslib_init (lib/reed_solomon/test_rslib.c:155) test_rslib 
> [ 231.759909][ C3] ? __pfx_test_rslib_init (lib/reed_solomon/test_rslib.c:153) test_rslib 
> [ 231.759915][ C3] do_one_initcall (init/main.c:1266) 
> [ 231.759922][ C3] ? kasan_save_track (arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69) 
> [ 231.759928][ C3] ? __pfx_do_one_initcall (init/main.c:1257) 
> [ 231.759934][ C3] ? __kasan_slab_alloc (mm/kasan/common.c:318 mm/kasan/common.c:345) 
> [ 231.759939][ C3] ? __kmalloc_cache_noprof (mm/slub.c:4119 mm/slub.c:4168 mm/slub.c:4324) 
> [ 231.759945][ C3] ? kasan_unpoison (mm/kasan/shadow.c:156 mm/kasan/shadow.c:182) 
> [ 231.759951][ C3] do_init_module (kernel/module/main.c:2910) 
> [ 231.759958][ C3] load_module (kernel/module/main.c:3376) 
> [ 231.759964][ C3] ? __pfx_load_module (kernel/module/main.c:3223) 
> [ 231.759969][ C3] ? security_kernel_post_read_file (security/security.c:3363) 
> [ 231.759975][ C3] ? kernel_read_file (arch/x86/include/asm/atomic.h:53 include/linux/atomic/atomic-arch-fallback.h:992 include/linux/atomic/atomic-instrumented.h:436 include/linux/fs.h:3060 fs/kernel_read_file.c:122) 
> [ 231.759982][ C3] ? __pfx_kernel_read_file (fs/kernel_read_file.c:38) 
> [ 231.759988][ C3] ? init_module_from_file (kernel/module/main.c:3565) 
> [ 231.759993][ C3] init_module_from_file (kernel/module/main.c:3565) 
> [ 231.759998][ C3] ? __pfx_init_module_from_file (kernel/module/main.c:3541) 
> [ 231.760004][ C3] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153) 
> [ 231.760011][ C3] idempotent_init_module (kernel/module/main.c:3577) 
> [ 231.760016][ C3] ? __pfx_idempotent_init_module (kernel/module/main.c:3569) 
> [ 231.760022][ C3] ? fdget (include/linux/atomic/atomic-arch-fallback.h:479 include/linux/atomic/atomic-instrumented.h:50 fs/file.c:1145 fs/file.c:1159) 
> [ 231.760028][ C3] ? security_capable (security/security.c:1142) 
> [ 231.760035][ C3] __x64_sys_finit_module (include/linux/file.h:62 include/linux/file.h:83 kernel/module/main.c:3600 kernel/module/main.c:3587 kernel/module/main.c:3587) 
> [ 231.760040][ C3] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
> [ 231.760046][ C3] ? do_mmap (mm/mmap.c:496) 
> [ 231.760053][ C3] ? __pfx_userfaultfd_unmap_complete (fs/userfaultfd.c:838) 
> [ 231.760060][ C3] ? __pfx_do_mmap (mm/mmap.c:288) 
> [ 231.760065][ C3] ? down_write_killable (arch/x86/include/asm/atomic64_64.h:20 include/linux/atomic/atomic-arch-fallback.h:2629 include/linux/atomic/atomic-long.h:79 include/linux/atomic/atomic-instrumented.h:3224 kernel/locking/rwsem.c:143 kernel/locking/rwsem.c:268 kernel/locking/rwsem.c:1303 kernel/locking/rwsem.c:1318 kernel/locking/rwsem.c:1590) 
> [ 231.760071][ C3] ? __pfx_down_write_killable (kernel/locking/rwsem.c:1586) 
> [ 231.760077][ C3] ? vm_mmap_pgoff (mm/util.c:584) 
> [ 231.760084][ C3] ? __pfx_vm_mmap_pgoff (mm/util.c:570) 
> [ 231.760089][ C3] ? fget (fs/file.c:1063) 
> [ 231.760095][ C3] ? fput (arch/x86/include/asm/atomic64_64.h:79 include/linux/atomic/atomic-arch-fallback.h:2913 include/linux/atomic/atomic-arch-fallback.h:3364 include/linux/atomic/atomic-long.h:698 include/linux/atomic/atomic-instrumented.h:3767 include/linux/file_ref.h:157 fs/file_table.c:501) 
> [ 231.760100][ C3] ? ksys_mmap_pgoff (mm/mmap.c:547) 
> [ 231.760105][ C3] ? syscall_exit_to_user_mode (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:92 include/linux/entry-common.h:232 kernel/entry/common.c:206 kernel/entry/common.c:218) 
> [ 231.760111][ C3] ? syscall_exit_to_user_mode (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:92 include/linux/entry-common.h:232 kernel/entry/common.c:206 kernel/entry/common.c:218) 
> [ 231.760116][ C3] ? do_syscall_64 (arch/x86/entry/common.c:102) 
> [ 231.760121][ C3] ? do_user_addr_fault (include/linux/rcupdate.h:882 include/linux/mm.h:741 arch/x86/mm/fault.c:1340) 
> [ 231.760127][ C3] ? syscall_exit_to_user_mode (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:92 include/linux/entry-common.h:232 kernel/entry/common.c:206 kernel/entry/common.c:218) 
> [ 231.760133][ C3] ? do_syscall_64 (arch/x86/entry/common.c:102) 
> [ 231.760137][ C3] ? exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:92 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539) 
> [ 231.760142][ C3] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
> [  231.760148][    C3] RIP: 0033:0x7f64c7711719
> [ 231.760154][ C3] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
> All code
> ========
>    0:	08 89 e8 5b 5d c3    	or     %cl,-0x3ca2a418(%rcx)
>    6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
>    d:	00 00 00 
>   10:	90                   	nop
>   11:	48 89 f8             	mov    %rdi,%rax
>   14:	48 89 f7             	mov    %rsi,%rdi
>   17:	48 89 d6             	mov    %rdx,%rsi
>   1a:	48 89 ca             	mov    %rcx,%rdx
>   1d:	4d 89 c2             	mov    %r8,%r10
>   20:	4d 89 c8             	mov    %r9,%r8
>   23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
>   28:	0f 05                	syscall
>   2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
>   30:	73 01                	jae    0x33
>   32:	c3                   	ret
>   33:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06f1
>   3a:	f7 d8                	neg    %eax
>   3c:	64 89 01             	mov    %eax,%fs:(%rcx)
>   3f:	48                   	rex.W
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
>    6:	73 01                	jae    0x9
>    8:	c3                   	ret
>    9:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06c7
>   10:	f7 d8                	neg    %eax
>   12:	64 89 01             	mov    %eax,%fs:(%rcx)
>   15:	48                   	rex.W
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250122/202501221029.fb0d574d-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
