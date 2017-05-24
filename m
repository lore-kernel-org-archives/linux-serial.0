From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] xilinx ps uart: Adding a kernel parameter for the
 number of xilinx ps uarts
Date: Wed, 24 May 2017 14:31:08 +0100
Message-ID: <20170524143108.682a548d@alans-desktop>
References: <20170520022154.6766-1-kernel.development@povil.us>
 <20170520172008.5a979e8a@alans-desktop>
 <517d864d-d230-3abc-eb3c-4b628dc4625f@xilinx.com>
 <20170522192636.5b578d89@alans-desktop>
 <1668f36e-f9be-7008-004a-e467a6813e0f@xilinx.com>
 <20170523210710.4e84dd2d@alans-desktop>
 <924433a1-7e27-6eb6-71ca-ed7baceb427f@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <924433a1-7e27-6eb6-71ca-ed7baceb427f@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Sam Povilus <kernel.development@povil.us>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, jslaby@suse.com, soren.brinkmann@xilinx.com
List-Id: linux-serial@vger.kernel.org

> I am not saying that config option is perfect solution. It is at least
> aligned with 5 others serial drivers in the tree.

And the fact people keep doing hacks jutifies continuing to make a mess.
Especialy as in this case it's entirely theoretical. Nobody has produced
actual hardware that hits the limit. Nobody has filed a bug, nobody is
impacted.

Creating extra CONFIG_ entries for junk like this is ridiculous, most of
the others at least have the excuse of being old code.

Generally it is better to call uart_register_driver from the probe method
because that way you don't waste time and memory registering drivers for
stuff that isn't even present however if you have no idea how many
devices there might be then you still really need to pass a suitable limit
and handle it internally dynamically allocating as needed.

If someone was hitting this in the real world and you posted a patch that
just changed the constant to 8 or 16 or whatever was needed I wouldn't
care too much, but adding CONFIG_ entries just makes stuff harder and
harder to config and more and more impossible to keep generic.

I keep hearing that the ARM folks are trying to get one unified kernel.
CONFIG_ options is not how to do that.

Alan
