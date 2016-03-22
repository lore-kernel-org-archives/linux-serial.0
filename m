From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 2/2] serial: amba-pl011: complete support to ZTE uart
Date: Mon, 21 Mar 2016 21:06:04 -0500
Message-ID: <56F0A88C.9050209@codeaurora.org>
References: <1457920282-14823-1-git-send-email-jun.nie@linaro.org>
 <1457920282-14823-2-git-send-email-jun.nie@linaro.org>
 <56F05C16.1030805@codeaurora.org>
 <CABymUCNKOgdLBLr2fZ4KhwmG+R4Zm-LHnfDppV-yiwUjRH4Nyg@mail.gmail.com>
 <56F0A628.2080607@codeaurora.org>
 <CABymUCOX5zws9QfXp5Wud2JBAYJZH4rxPRVVgbk7tRvbUUHChA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CABymUCOX5zws9QfXp5Wud2JBAYJZH4rxPRVVgbk7tRvbUUHChA@mail.gmail.com>
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
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, G Gregory <graeme.gregory@linaro.org>, Jason Liu <jason.liu@linaro.org>, Andre Przywara <andre.przywara@arm.com>, linux-serial@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Jun Nie wrote:
> That's a fair comment. I suppose all platform need to enable clock for
> the device. For device tree case, we need these code for clock
> enabling.

But why do you need to enable the clock?  The pl011 driver works fine 
for every platform without your patch.  If the ZTE platform needs to 
call clk_get() in order to work, than that is something different about 
your platform.

> For ACPI case, it may be handled automatically. If you agree
> my opinion, I will move these lines to patch 1. Please correct me if I
> am wrong.

I think you need to create a separate patch that adds that call, and 
make sure it's tested by other platforms before it gets accepted.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
