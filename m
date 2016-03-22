From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] serial: amba-pl011: make platform driver generic
Date: Tue, 22 Mar 2016 12:38:39 +0000
Message-ID: <20160322123839.GO19428@n2100.arm.linux.org.uk>
References: <1457920282-14823-1-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1457920282-14823-1-git-send-email-jun.nie@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jun Nie <jun.nie@linaro.org>
Cc: peter@hurleysoftware.com, graeme.gregory@linaro.org, jason.liu@linaro.org, andre.przywara@arm.com, timur@codeaurora.org, linux-serial@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Mar 14, 2016 at 09:51:21AM +0800, Jun Nie wrote:
> make sbsa uart platform driver more generic so that platform
> driver code can be reused by ZTE uart platform driver.

I think it's known that I don't like the platform driver in here, and
I'm less than happy seeing it get extended.  Can we try to come up with
a better solution which allows ZTE to use the AMBA bus support while
still allowing it to be properly detected?

The reason is that the platform bus behaves in a completely different
way to the amba bus - platform bus does no runtime PM support whereas
amba bus does, and I don't want to see that difference eventually
impacting on this driver.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
