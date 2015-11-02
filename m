From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH DRAFT 1/2] drivers: serial: PL011: refactor register access
Date: Mon, 2 Nov 2015 07:27:19 -0600
Message-ID: <563764B7.6040202@codeaurora.org>
References: <1446467042-24494-1-git-send-email-andre.przywara@arm.com>
 <1446467042-24494-2-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1446467042-24494-2-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>, Jun Nie <jun.nie@linaro.org>, Peter Hurley <peter@hurleysoftware.com>
Cc: Andrew.Jackson@arm.com, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Andre Przywara wrote:
> * to support UARTs with different register offsets (ZTE)
> * to support a different bus access width (16 bits vs. 32 bits)

How exactly does this patch provide this?  The code is still calling a 
fixed function.  How will the code dynamically call a 32-bit version 
instead of a 16-bit version on platforms that need it?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
