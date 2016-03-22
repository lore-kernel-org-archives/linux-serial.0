From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH 1/2] serial: amba-pl011: make platform driver generic
Date: Tue, 22 Mar 2016 09:25:46 +0800
Message-ID: <CABymUCPMV+L9sRyVPS4rrimr-PcugvGzgVWOCW63psAWY2hSPg@mail.gmail.com>
References: <1457920282-14823-1-git-send-email-jun.nie@linaro.org>
 <56F04FC5.7040907@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <56F04FC5.7040907@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, G Gregory <graeme.gregory@linaro.org>, Jason Liu <jason.liu@linaro.org>, Andre Przywara <andre.przywara@arm.com>, linux-serial@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

2016-03-22 3:47 GMT+08:00 Timur Tabi <timur@codeaurora.org>:
> Jun Nie wrote:
>
>> -       snprintf(uap->type, sizeof(uap->type), "SBSA");
>> +       snprintf(uap->type, sizeof(uap->type), "PL011 plat");
>
>
> I'm not crazy about this.  I think you need to add a "const char *name"
> field to 'struct vendor_data'.

Will address this suggestion in next version patch. How about "PL011
SBSA" "PL011 ZTE" "PL011 ARM rev1" "PL011 ST rev1"?

Jun
>
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum, a Linux Foundation collaborative project.
