From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] serial: core: Fix iotype userspace breakage
Date: Sun, 01 Mar 2015 11:03:47 -0500
Message-ID: <54F33863.3050104@hurleysoftware.com>
References: <1425223096-17635-1-git-send-email-peter@hurleysoftware.com> <CAJiQ=7D-MKjh4aEcAAvqmSf7dAKY99iQf+8tOGZAOViQPpuFeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAJiQ=7D-MKjh4aEcAAvqmSf7dAKY99iQf+8tOGZAOViQPpuFeg@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 03/01/2015 10:44 AM, Kevin Cernekee wrote:

[...]

> Whoops, I had no clue userland cared about these... thanks for the fix.

Yeah, totally non-obvious.
That's why my other patch redefines these with the uapi identifiers.

Regards,
Peter Hurley
