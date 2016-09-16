From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v3 1/3] tty: amba-pl011: define flag register bits for ZTE
 device
Date: Fri, 16 Sep 2016 12:11:05 -0500
Message-ID: <57DC27A9.3060307@codeaurora.org>
References: <1467968441-4056-1-git-send-email-shawn.guo@linaro.org>
 <1467968441-4056-2-git-send-email-shawn.guo@linaro.org>
 <b549cd51-a81f-b693-e3c2-9e3c598d3d9e@arm.com>
 <20160916163952.GH1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160916163952.GH1041@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Jason Liu <jason.liu@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, xie.baoyou@zte.com.cn, linux-serial@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>, Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Russell King - ARM Linux wrote:
> Maybe what we should've done with ZTE is insisted that they implement
> a complete new driver, rather than trying to shoe-horn it into PL011
> even though it is in theory PL011.

When I suggested that a year ago, I was shot down:

http://www.spinics.net/lists/arm-kernel/msg455888.html

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
