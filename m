From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 1/2] serial: amba-pl011: make platform driver generic
Date: Mon, 21 Mar 2016 14:47:17 -0500
Message-ID: <56F04FC5.7040907@codeaurora.org>
References: <1457920282-14823-1-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
To: Jun Nie <jun.nie@linaro.org>, andre.przywara@arm.com, linux@arm.linux.org.uk, graeme.gregory@linaro.org, peter@hurleysoftware.com, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, shawn.guo@linaro.org
Cc: jason.liu@linaro.org
List-Id: linux-serial@vger.kernel.org

Jun Nie wrote:

> -	snprintf(uap->type, sizeof(uap->type), "SBSA");
> +	snprintf(uap->type, sizeof(uap->type), "PL011 plat");

I'm not crazy about this.  I think you need to add a "const char *name" 
field to 'struct vendor_data'.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
