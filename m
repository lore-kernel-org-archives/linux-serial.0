From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [GIT PULL] TTY/Serial patches for 4.3-rc1
Date: Thu, 20 Aug 2015 21:03:09 -0300
Message-ID: <CAOMZO5Cqj7gSQ0ZW_rkUmF=orvj58uaSx+AmZWEUyp1dRDF9fg@mail.gmail.com>
References: <20150820191121.GA24594@kroah.com>
	<20150821095733.479a51aa@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150821095733.479a51aa@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Greg KH <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Stephen,

On Thu, Aug 20, 2015 at 8:57 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Greg,
>
> On Thu, 20 Aug 2015 12:11:21 -0700 Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> All have been in linux-next with no reported issues.
>
> Except see below.
>
>> Eduardo Valentin (4):
>>       serial: imx: introduce serial_imx_enable_wakeup()
>
> I reported that this commit breaks the arm multi_v7_defconfig build and
> I have seen no fix applied.
>
> I have been applying the following patch for a few days but do not know
> if it is the correct resolution:

This is the correct solution as there is really no imx6sl-fox-p1.dts file.

Regards,

Fabio Estevam
