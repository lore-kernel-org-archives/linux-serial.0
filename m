From: hpa@zytor.com
Subject: Re: Insanely high baud rates
Date: Wed, 10 Oct 2018 13:20:48 -0700
Message-ID: <16D6AB22-697E-498C-A5B2-3AD90B567E86@zytor.com>
References: <3fcef1c1-d746-ae82-c0e6-f079b1a53ffb@zytor.com> <20181010211717.30c1f052@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010211717.30c1f052@alans-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: linux-serial@vger.kernel.org

On October 10, 2018 1:17:17 PM PDT, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>On Tue, 9 Oct 2018 12:19:04 -0700
>"H. Peter Anvin" <hpa@zytor.com> wrote:
>
>> [Resending to a wider audience]
>> 
>> In trying to get the termios2 interface actually implemented in
>glibc,
>> the question came up if we will ever care about baud rates in excess
>of
>> 4 Gbps, even in the relatively remote future.
>
>Even RS485 at 4MBits involves deep magic. I think we are fairly safe.
>Not
>only that but our entire tty layer isn't capable of sustaining anything
>even remotely in that range.
>
>I think its non issue.
>
>Alan

I'm mostly wondering if it is worth future-proofing for new transports. It sounds like we can have a consensus on leaving the upper 4 bits of the speed fields reserved, but leave the details of implementation for the future?
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
