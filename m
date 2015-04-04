From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2] earlycon: 8250: Fix command line regression
Date: Fri, 3 Apr 2015 20:28:45 -0700
Message-ID: <CAE9FiQXmh24Cwqr39a=8VGc4ZpqZNRsMM-M84GX+MCDS3SA4+Q@mail.gmail.com>
References: <1428102229-26103-1-git-send-email-peter@hurleysoftware.com>
	<1428105875-4038-1-git-send-email-peter@hurleysoftware.com>
	<CAE9FiQWvxfg_mG4pab=yBHKbq8C+_ujiHtx2mmzS6aEfMzG8Jw@mail.gmail.com>
	<551F4C6C.6040108@hurleysoftware.com>
	<CAE9FiQW=TvocnF=xWh3V2ARAUaR8pSPnv0Y3ixMWfE+KZH138A@mail.gmail.com>
	<551F55DC.1000706@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <551F55DC.1000706@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Rob Herring <robh@kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Apr 3, 2015 at 8:09 PM, Peter Hurley <peter@hurleysoftware.com> wrote:

>
> All this automatic behavior and aliases for the same things just
> adds unnecessary complexity and maintenance burden, without measurable
> gain.
>
> The real tragedy is that all this was totally unnecessary; what was
> wrong with "earlycon=uart,io,0x3f8 console=ttyS0"?

When I worked on the patch

| commit 18a8bd949d6adb311ea816125ff65050df1f3f6e
| Date:   Sun Jul 15 23:37:59 2007 -0700
|
|    serial: convert early_uart to earlycon for 8250

Andrew requested that.

Thanks

Yinghai
