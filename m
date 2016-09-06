From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: Re: [PATCH 4/7] serial: 8250_fintek: Rearrange function
Date: Tue, 6 Sep 2016 09:56:19 +0800
Message-ID: <564d5aa9-6cde-2bac-afe2-39956caa93f7@gmail.com>
References: <1472701196-14795-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1472701196-14795-5-git-send-email-hpeter+linux_kernel@gmail.com>
 <CAPybu_09HrXc2p+KzqRwcJKGDFCgNv5gMtNYK5Fx4SoJ2gMC3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPybu_09HrXc2p+KzqRwcJKGDFCgNv5gMtNYK5Fx4SoJ2gMC3Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, =?UTF-8?B?UEEyMCBUT00gVFNBSSDolKHlrpfkvZE=?= <tom_tsai@fintek.com.tw>, Peter H <peter_hong@fintek.com.tw>, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Ricardo, Greg,

Ricardo Ribalda Delgado 於 2016/9/1 下午 07:17 寫道:
> On one previous patch you almost rewrote theset_irq_mode function and
> added the prototype. It might be a good moment to move the whole
> function up.
>

I had try with merge the following 2 patches in local,
  1: serial: 8250_fintek: Set IRQ Mode when port probed
  2: serial: 8250_fintek: Rearrange function

but it made the patch less readable. So I'll try to add
set_irq() with prototype first, and change this function location
with other patch.

Could you give me some comments, Greg? Should I merge it?

Thanks
-- 
With Best Regards,
Peter Hong
