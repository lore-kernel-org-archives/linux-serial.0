From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v3] serial: 8250: convert to threaded IRQ
Date: Thu, 7 Dec 2017 14:45:09 +0000
Message-ID: <20171207144509.482b3e45@alans-desktop>
References: <20171204152627.23906-1-dzagorui@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171204152627.23906-1-dzagorui@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Denys Zagorui <dzagorui@cisco.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon,  4 Dec 2017 17:26:27 +0200
Denys Zagorui <dzagorui@cisco.com> wrote:

> During using virtualization it is common to see
> many "too much work for irq*" messages.

Your emulator is buggy.

NAK

You are adding a ton of overhead to an absolutely performance critical
path on real hardware. We absolutely cannot have 16450 or 16550A UARTS
being serviced via a threaded IRQ.

Fix your emulator. You are getting the problem because your serial port
emulation isn't doing timing correct queueing of characters. If you are
modelling 115,200 baud then don't queue characters faster than that or
batch them excessively. We went to 512 as the pass limit to allow
virtualization layers to get this right more easily as you don't have to
do timing on tiny batches.

(And if you need performance of any kind stop using the uart emulation
and use virtio)

Alan
