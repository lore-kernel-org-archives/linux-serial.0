From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: Remove 68328 driver
Date: Mon, 4 Jan 2016 10:30:31 +0000
Message-ID: <20160104103031.655b6f61@lxorguk.ukuu.org.uk>
References: <1449830170-15096-1-git-send-email-frederik.voelkel@fau.de>
	<1450438103-1059-1-git-send-email-frederik.voelkel@fau.de>
	<CAMuHMdW6r_QszpXTj1FLtOfjzPqDCU7UcF6OT+7MgW8uo01KYA@mail.gmail.com>
	<5689FD36.4020609@westnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <5689FD36.4020609@westnet.com.au>
Sender: linux-m68k-owner@vger.kernel.org
To: Greg Ungerer <gregungerer@westnet.com.au>
Cc: Linux/m68k <linux-m68k@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Frederik =?UTF-8?B?VsO2bGtlbA==?= <frederik.voelkel@fau.de>, Jiri Slaby <jslaby@suse.com>, Greg KH <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-kernel@i4.cs.fau.de, Lukas Braun <lukas.braun@fau.de>, uClinux development list <uclinux-dev@uclinux.org>
List-Id: linux-serial@vger.kernel.org

On Mon, 4 Jan 2016 15:03:50 +1000
Greg Ungerer <gregungerer@westnet.com.au> wrote:

> If 68328serial.c is removed is there any point keeping the
> architecture support for 68328 platforms?
> 
> The 68328serial.c provides pretty much the only type of console
> that can be used on these devices. They are largely useless
> without this

Probably we should - unless someone wants to stand up and say "actually
I'm using this with current kernels, need it, and I'll maintain it"

Somehow I doubt anyone is.

Alan
