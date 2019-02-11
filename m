From: Christoph Hellwig <hch@lst.de>
Subject: RFC: drop ISA support in the synlink tty driver?
Date: Mon, 11 Feb 2019 14:25:33 +0100
Message-ID: <20190211132534.29407-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Greg and Jiri,

I've been working hard to get rid of the remaining callers the pass a
NULL struct device to the DMA mapping functions and am almost done.

The only non-trivial driver is the synclink driver, which has legacy
early 90s style ISA support that doesn't use the device model at all.

In theory we could convert it to an isa_driver, but without testing
that seems rather dangerous.  So for now I would suggest that we
remove the ISA support in this driver - if anyone cares enough we
can resurrect it from the git history and convert it to use the driver
model.
