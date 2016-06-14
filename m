From: dinh.linux@anniebear.net
Subject: Re: [RFC RESEND] serial: 8250: fix regression in 8250 uart driver
Date: Tue, 14 Jun 2016 10:27:47 -0500
Message-ID: <cca9fb6eca58d8a29e3070e3f34fa40f.squirrel@emailmg.ipower.com>
References: <575F7325.3030907@kernel.org>
    <1465897220.30123.26.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465897220.30123.26.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>, heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> On Mon, 2016-06-13 at 21:59 -0500, Dinh Nguyen wrote:
>> Apologies, but my original email bounced for Andy and Heikki,
>> resending.
>> ----
>
> I suppose this one, i.e. commit dd4e91d538b3 ("dmaengine: slave means at
> least one of DMA_SLAVE, DMA_CYCLIC"), solves the issue.
>

Hmm...that commit didn't seem to fix my issue.

In regard to Peter's reply:

"The error is that your dmaengine driver doesn't support the functionality
required by the 8250 driver."

Does this mean that the 8250_dw.c driver can no longer use DMA?

Dinh
