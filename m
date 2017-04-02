From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for embedded systems
Date: Sun, 02 Apr 2017 13:47:42 -0700
Message-ID: <87pogur0y9.fsf@firstfloor.org>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170401222119.25106-1-nicolas.pitre@linaro.org> (Nicolas
        Pitre's message of "Sat, 1 Apr 2017 18:21:14 -0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Nicolas Pitre <nicolas.pitre@linaro.org> writes:
>
> Of course, making it "mini" means there are limitations to what it does:
>
> - This supports serial ports only. No VT's, no PTY's.

No PTYs seems like a big limitation. This means no sshd?

> But again, most small embedded systems simply don't need those things.

They don't need a (debug) way to login over the network? Hard to
believe.

Most of the other stuff we could indeed do without even on larger
systems.

-Andi
