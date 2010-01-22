From: Valentin Longchamp <valentin.longchamp@epfl.ch>
Subject: Re: [PATCH] serial imx.c: fix CTS trigger level lower to avoid	lost
	chars
Date: Fri, 22 Jan 2010 11:14:26 +0100
Message-ID: <4B597A82.4020906@epfl.ch>
References: <1264109163-28739-1-git-send-email-valentin.longchamp@epfl.ch>
	<20100121220653.GA21010@pengutronix.de>
	<20100121221133.GA30419@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100121221133.GA30419@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Russell King - ARM Linux wrote:
> On Thu, Jan 21, 2010 at 11:06:53PM +0100, Wolfram Sang wrote:
>> CCing linux-serial
>>
>> On Thu, Jan 21, 2010 at 10:26:03PM +0100, Valentin Longchamp wrote:
>>> The imx CTS trigger level is left at its reset value that is 32
>>> chars. Since the RX FIFO has 32 entries, when CTS is raised, the
>>> FIFO already is full. However, some serial port devices first empty
>>> their TX FIFO before stopping when CTS is raised, resulting in lost
>>> chars.
>> ? Isn't that a flaw of the other side? Have you spotted other serial drivers
>> doing the same as your patch?
> 
> Arguably, but it's common behaviour of 16550A's and similar.

First I wanted to fix the fact that the imx serial hardware only raises 
the CTS pin when the oferflowing char begins to be set. I would have 
solved this by setting the CTS trigger value to 31 instead of 32. But 
when I talked with one colleague he told me about 16550A (that is 
present nearly everywhere) that empty their TX FIFO, so I lowered it to 16.

Val

-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp@epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEB3494, Station 9, CH-1015 Lausanne
