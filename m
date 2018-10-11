From: hpa@zytor.com
Subject: Re: Insanely high baud rates
Date: Thu, 11 Oct 2018 07:14:30 -0700
Message-ID: <8A583BC1-A295-48D2-B4C3-3E70AA50D035@zytor.com>
References: <3fcef1c1-d746-ae82-c0e6-f079b1a53ffb@zytor.com> <20181010211717.30c1f052@alans-desktop> <16D6AB22-697E-498C-A5B2-3AD90B567E86@zytor.com> <20181011133134.085624af@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181011133134.085624af@alans-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: linux-serial@vger.kernel.org

On October 11, 2018 5:31:34 AM PDT, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>> I'm mostly wondering if it is worth future-proofing for new
>transports. It sounds like we can have a consensus on leaving the upper
>4 bits of the speed fields reserved, but leave the details of
>implementation for the future?
>
>It seems reasonable, although I think the reality is that any future
>transport is not going to be a true serial link, but some kind of
>serial
>emulation layer. For those the speed really only matters to tell
>editors
>and the like not to bother being clever.
>
>I mean - what is the baud rate of a pty  ?
>
>Alan

Whatever the master wants it to be...
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
