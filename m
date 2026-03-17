Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063C33AEF4A
	for <linux-serial@vger.kernel.org>; Tue, 17 Mar 2026 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747959; cv=pass; b=FE0mJnRUhjx42PHEoHmtjAZNkCjyga6N5QCjkqQSsYP08SORufFYOKW1qZdEcNx4lehDp1k7e0naGRHSLDeU3TjVtJZEbolU1w3wgYUtods7oeC6Pr+gANNnfNR+8qu6USqJmpUQngsKDrPQ9ZkXVlD+7QVjSvOe0xlJUzjhDNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747959; c=relaxed/simple;
	bh=/dZ8eemKmVtBY2mkzOsItLB1R+RVETssjP8jIwsEqsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AI80Sr0VuqjGKPtQe+crhkD+fOqvS1rFS5ayIOxHjwcQ9reUognHG30GYXRNLPc3kFTipkHn9QwQ9l6kkPvsqhqm0PnUPIVyHhw/xewU9q2MxGETokB+/dC6fS7ipdKv6RUuzVAhcYv29dRQ+rC/Wt0ze8DZI8DHiYswD1U/xSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FH9Y/hAv; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FH9Y/hAv"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4836d9d54f6so7056135e9.1
        for <linux-serial@vger.kernel.org>; Tue, 17 Mar 2026 04:45:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773747956; cv=none;
        d=google.com; s=arc-20240605;
        b=Myxbj5prsBq4x+DsfLkClMq6Fl18+Xc8eCyb7h6jD3AYtbSNOYSt5e8BES9Igd+pVC
         l/GVGOMXYdySBAdAvW0X4UKBNNTfGsUjXVvrP4pRD0poQKcQQUhfsRTY4Cvoj+5gT4ND
         ALSyMAUDUbHugFbDKX19MPX4zqZmNFFf2pmXxyJoG9L5ChO9FM4omy9BBqvrw3tBrO/a
         ZN7ExJAWw0SVJCE6lY7c+aJNqULV/7+2z3J+NLUeLakUVoysGdRvV1qXPg++vW6DWdio
         ma/biryL7l0+v5q3aGXQH0ttPfoxaeB/l04gzSwiZ2RW2KLUlRLUxc5AfdjAQkiIGMnO
         tOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BWkKD2fkibRW1P9sHEn0ViaxXUKwkoQK7XP3YmrFnQI=;
        fh=OhouWgnvIE29Hyo+hh0slD5xaCGBhXiESHE6u/NYJqY=;
        b=FO01Somj86w2gFEaIdW0CiWNgRb7SDlMou+x98HuEPuWisllGNtW4RCqcU5oHp6Bft
         I7xS3wVEDlkAqvbIWd/Hg/zTqG8I3anMtsN565TZ06Z/o0YAb2ADoBohbgGH5PtoDIIt
         52Yu5sjGOrrxTAL7HOS6qmWjRtXh66rpEHCKlSLRm7QXUEkw0+3A5/MKMzA5xPULPqWG
         bGWeXwNvhrG0fr9SqzhneR8YjK7F+AgrdqTDaz3kFMtA0HlJiT+ZkGbxwgN3PWhRonVa
         Al3wzuOD5Zif8AzF8bllzdwIFPVk+n5T1Wlb/t1Ar61IQegdFghYZuwkTwNJTYaId6lX
         nJzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773747956; x=1774352756; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BWkKD2fkibRW1P9sHEn0ViaxXUKwkoQK7XP3YmrFnQI=;
        b=FH9Y/hAvhbWgeJW7qTudFrxWlFhCvNRgjbuNVsyU7qhnjyK+HM/DTdVwjgMZDduSTD
         iBEl1R/VgsK+lfOYQ0Q7sp94LDPrr+xWR/IeUnhX7VPdDwuUkNpWV1f2LRwMeLUgtDxO
         3iyQKJscgRnjQwJ4HAnK+z/Jv8y84H03bZEKFlckPIa+pF+weE7T/vAz/VtR6JzZ3xOH
         PonoKZczuRJZ7XCXkC+PkZ+VnJqKOkzIn8BrKsxJs8znoyG8mEaZcNhwyB2YjcQvmyqH
         /4lPT9J59PqPYOXWEtsT9tLWJlIwkI3G8ucj0WgVcyEILx9bQaUvN7+qFIRyZgOh+7Z5
         39Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773747956; x=1774352756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWkKD2fkibRW1P9sHEn0ViaxXUKwkoQK7XP3YmrFnQI=;
        b=r2A/xGTtJ0kTemuIEJWpPPcxGt3mx0ekNAL2UgcOUNW9f+4InHPTrKCOnrFlHB6YKD
         MiU6t2JcRuBBZDJXwshfkkluwwrqB5979Xe0CKZni3ILQ88YmUGcxOYB+8IOlDSW/fu/
         b1ZYFEA36N/mTLoTGS/IkD0OuoF3gHAVAMxmRzAWiYKxLZs6QIuGquayX+JuWTb6JILD
         KlWcAjQbDhyPbx5VQl5FWWLbLhD0WMQelHcqDTQEz9ruOZpKTaJyTUYOGDoNnJYIqmU1
         mI0BC82LSvwTQUTQn5BuWczs3K+fhTTo193FaGqeR2lNpUq4tl71L/Qv4AJEnm0SLtRf
         Pdug==
X-Forwarded-Encrypted: i=1; AJvYcCXn1he6EzrCWjIri9dPEUlEMe9IoZFCzmq0lgLN/803lPESZ3vmwkwZFnDQSUU5KZx8n+eTfddDCMpGlWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEfEEanh/Tezcl2hkLC++3Pg5Elrz3bdpQlcfmOUoikjgA94N/
	i+MbDH45Ivao5MpWObCOiwFLK32dIU3PBczmfdswQy9iTvjD8EnhZL1TiqG2JkrmFL2JCRhPdgN
	HJy2TDz9TsMEDuyyHRSo3qLCtrH5rbAo=
X-Gm-Gg: ATEYQzzWEBpcDemJRxBXuQlkNlDtGGazxz6O7mZnCcywmMhIlFa/qGOS4eaIH6oWvlI
	v7QzfYPShusNflFxbzxZbLbNYobct8tHcSvEgV41hmprB8wMG+/OglM3HkdPsiG4l8bNrqShuk0
	itGDPpjh+EQ0jLL61HKOlkm8ldFBUK6l4AaracryaVtvPsV2lb0XgkMH4ZIF2J+gmNpKpG9u1fv
	3eptiggqOli+CaVauVJWZsjvrw0sLFkLdOkKrpEXcSf9/0a6ikze72swe1O/Wl0szAIL45+EyAm
	cUv3iVB0KQq6OsQb
X-Received: by 2002:a05:600c:6007:b0:486:b967:5c9b with SMTP id
 5b1f17b1804b1-486b9675eeamr6153375e9.3.1773747956038; Tue, 17 Mar 2026
 04:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317081911.24390-1-ziyuzhang201@gmail.com> <2026031702-unsheathe-gizmo-6851@gregkh>
In-Reply-To: <2026031702-unsheathe-gizmo-6851@gregkh>
From: ziyu zhang <ziyuzhang201@gmail.com>
Date: Tue, 17 Mar 2026 19:45:44 +0800
X-Gm-Features: AaiRm53u7xxhRY5GX7aE8FaO1kqa5CD-ueAYTE9W-oItCyiUENgnYf642JvFew8
Message-ID: <CACPoYJweQ8iKp+zKNZ1nre22rq4JGNn7xqJ2TSzDSLtKMPoybw@mail.gmail.com>
Subject: Re: [PATCH v2] tty: n_tty: annotate lockless read of ldata->icanon in input_available_p()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, baijiaju1990@gmail.com, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

> No this robot did not report this issue :(

Sorry, that was my mistake. It is my first time submitting a patch. I
misunderstood what the robot meant.
I will definitely drop this tag and be more careful with submission
guidelines next time.

> Given that the previous patch was not even tested, how was this found
> and most importantly, tested?

My apologies for sending the v1 patch without properly compile-testing
it first.
It is a data race found by our testing tool. The detailed report is
showed below.

Kernel panic: ============ DATARACE ============
VarName 11902078599461647536, BlockLineNumber 36, IrLineNumber 3, is write 1
Function: found_watchpoint kernel/kccwf/wp_checker.c:126 [inline]
Function: watchpoints_monitor+0x1ac2/0x22a0 kernel/kccwf/wp_checker.c:217
Function: kccwf_rec_mem_access+0x275e/0x2b70
Function: n_tty_set_termios+0x5d1/0x37a0 drivers/tty/n_tty.c:1793
Function: tty_set_termios+0x112d/0x1b80 drivers/tty/tty_ioctl.c:348
Function: set_termios+0xc1b/0xca0 drivers/tty/tty_ioctl.c:512
Function: tty_mode_ioctl+0x5e5/0x9d0
Function: n_tty_ioctl_helper+0xe5/0x8f0 drivers/tty/tty_ioctl.c:982
Function: n_tty_ioctl+0x253/0x730 drivers/tty/n_tty.c:2509
Function: tty_ioctl+0x1cfb/0x3070 drivers/tty/tty_io.c:2801
Function: vfs_ioctl fs/ioctl.c:51 [inline]
Function: __do_sys_ioctl fs/ioctl.c:598 [inline]
Function: __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
Function: do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
Function: do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
Function: entry_SYSCALL_64_after_hwframe+0x77/0x7f
Function: 0x0
============OTHER_INFO============
VarName 16560329611981062523, BlockLineNumber 32, IrLineNumber 1,
watchpoint index 38236
Function: set_report_info+0xbd/0x2c0 kernel/kccwf/report.c:57
Function: setup_watchpoint kernel/kccwf/wp_checker.c:158 [inline]
Function: watchpoints_monitor+0xe0e/0x22a0 kernel/kccwf/wp_checker.c:239
Function: kccwf_rec_mem_access+0x275e/0x2b70
Function: input_available_p drivers/tty/n_tty.c:1923 [inline]
Function: n_tty_poll+0x3f5/0x16b0 drivers/tty/n_tty.c:2452
Function: tty_poll+0x224/0x4a0 drivers/tty/tty_io.c:2199
Function: vfs_poll include/linux/poll.h:82 [inline]
Function: select_poll_one fs/select.c:480 [inline]
Function: do_select+0xce7/0x13d0 fs/select.c:536
Function: core_sys_select+0x3e8/0x5d0 fs/select.c:677
Function: do_pselect fs/select.c:759 [inline]
Function: __do_sys_pselect6 fs/select.c:802 [inline]
Function: __se_sys_pselect6+0x1d8/0x240 fs/select.c:793
Function: do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
Function: do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
Function: entry_SYSCALL_64_after_hwframe+0x77/0x7f
=================END==============

> What error was reported that this now
> fixes?

Error: cannot pass bit-field as __auto_type initializer in C.
The detailed error is showed below.

drivers/tty/n_tty.c:1913:6: error: cannot pass bit-field as
__auto_type initializer in C
    1913 |         if (data_race(ldata->icanon) && !L_EXTPROC(tty))
         |             ^
   include/linux/compiler.h:194:13: note: expanded from macro 'data_race'
     194 |         auto __v = (expr);
            \
         |                    ^
   1 error generated.

vim +1913 drivers/tty/n_tty.c

  1906
  1907  static inline int input_available_p(const struct tty_struct
*tty, int poll)
  1908  {
  1909          const struct n_tty_data *ldata = tty->disc_data;
  1910          int amt = poll && !TIME_CHAR(tty) && MIN_CHAR(tty) ?
MIN_CHAR(tty) : 1;
  1911
  1912          /* data_race: benign race, poll readiness is best-effort */
> 1913          if (data_race(ldata->icanon) && !L_EXTPROC(tty))
  1914                  return ldata->canon_head != ldata->read_tail;
  1915          else
  1916                  return ldata->commit_head - ldata->read_tail >= amt;
  1917  }
  1918

> What changed to cause this to now be needed?

In my initial v1 patch, I carelessly wrapped the bit-field directly in
the data_race() macro without locally compile-testing it.
The data_race(expr) macro internally utilizes __auto_type (or typeof).
And the C standard strictly prohibits passing a bit-field directly as
an initializer for __auto_type.
Adding !! forces the bit-field to be evaluated as a standard
boolean/integer expression, which bypasses this compiler restriction.
I sincerely apologize for the oversight in my initial patch and any
extra work it may have caused.
Thank you for your time and patience. I will submit a v3 patch if necessary.

Best regards,
Ziyu Zhang
