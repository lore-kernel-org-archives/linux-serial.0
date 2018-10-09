From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Insanely high baud rates
Date: Tue, 9 Oct 2018 12:19:04 -0700
Message-ID: <3fcef1c1-d746-ae82-c0e6-f079b1a53ffb@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: linux-serial@vger.kernel.org

[Resending to a wider audience]

In trying to get the termios2 interface actually implemented in glibc,
the question came up if we will ever care about baud rates in excess of
4 Gbps, even in the relatively remote future.

If this is something we care about *at all*, I would like to suggest
that rather than defining yet another kernel interface, we steal some
bits from the MSB of the speed fields, alternatively one of the c_cc
bytes (all  likearchitectures seem to have c_cc[18] free) or some field,
if we can find them, in c_cflags, to indicate an exponent.

With 5 bits from the top of the speed fields, the current values would
be identical up to 248 Gbps, and values up to ~288 Pbps would be
encodable ±2 ppb.

In the short term, all we would have to do in the kernel would be
erroring out on baud rates higher than 0x0fffffff (2^28-1 due to
implicit one aliasing rhe first bit of a 5-bit exponent – less than 2^27
are functionally denorms.) However, I'd like to put the glibc
infrastructure for this now if this is something we may ever be
interested in.

Thoughts?
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
