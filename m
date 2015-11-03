From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH DRAFT 0/2] Sketch for ZTE ZX296702 UART integration
Date: Tue, 3 Nov 2015 13:43:49 +0000
Message-ID: <20151103134349.GV8644@n2100.arm.linux.org.uk>
References: <1446467042-24494-1-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1446467042-24494-1-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Andrew.Jackson@arm.com, Timur Tabi <timur@tabi.org>, linux-serial@vger.kernel.org, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

NAK for both patches.

I'm not happy with these patches since they totally ignore all the
comments I made during the last rounds of trying to add this.  That
disgusts me.

So, I'm working on a replacement set of patches which does this the
right way, and I'll post them later today or early tomorrow, depending
on when I get them tested on the Versatile / Juno platforms.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
