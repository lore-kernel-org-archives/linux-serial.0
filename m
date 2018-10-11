From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Insanely high baud rates
Date: Thu, 11 Oct 2018 13:31:34 +0100
Message-ID: <20181011133134.085624af@alans-desktop>
References: <3fcef1c1-d746-ae82-c0e6-f079b1a53ffb@zytor.com>
        <20181010211717.30c1f052@alans-desktop>
        <16D6AB22-697E-498C-A5B2-3AD90B567E86@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <16D6AB22-697E-498C-A5B2-3AD90B567E86@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hpa@zytor.com
Cc: linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: linux-serial@vger.kernel.org

> I'm mostly wondering if it is worth future-proofing for new transports. It sounds like we can have a consensus on leaving the upper 4 bits of the speed fields reserved, but leave the details of implementation for the future?

It seems reasonable, although I think the reality is that any future
transport is not going to be a true serial link, but some kind of serial
emulation layer. For those the speed really only matters to tell editors
and the like not to bother being clever.

I mean - what is the baud rate of a pty  ?

Alan
