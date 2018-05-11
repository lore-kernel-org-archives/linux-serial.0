From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: Add Mediatek SoC MT8183 and evaluation
 board dts and Makefile
Date: Fri, 11 May 2018 13:19:54 +0200
Message-ID: <b2dfc052-bbf4-2154-985d-b1e2e7717cf4@gmail.com>
References: <1526019083-20237-1-git-send-email-erin.lo@mediatek.com>
 <1526019083-20237-3-git-send-email-erin.lo@mediatek.com>
 <860cba8a-3af8-31d6-ec3f-81706d2d998b@gmail.com>
 <1526035267.13828.13.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1526035267.13828.13.camel@mtksdaap41>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Erin Lo <erin.lo@mediatek.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, Ben Ho <Ben.Ho@mediatek.com>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org



On 05/11/2018 12:41 PM, Erin Lo wrote:
> On Fri, 2018-05-11 at 10:36 +0200, Matthias Brugger wrote:
>>
>> On 05/11/2018 08:11 AM, Erin Lo wrote:
[...]
>>
>> I wonder if there aren't any other devices which can be supported out of the box.
>> I understand that for now we are missing the clock driver and the pinctrl
>> driver. Are you planning to submit them in the near future?
>>
>> I'm asking because I don't want to bloat the dts with boards that only can boot
>> to an initramfs with a serial console. Especially if there is no HW + datasheet
>> available for anyone in the community who wants to work on this.
>>
>> Regards,
>> Matthias
>>
>> Regards,
>> Matthias
> 
> 
> We have implement clock and pinctrl driver these days, and plan to
> submit them maybe next month.
> After that we will submit other drivers of MT8183 continuously.
> 

I'm happy to hear this. So in this case I'm fine with merging these once you
figured out the dt-bindings.

Thanks a lot,
Matthias
