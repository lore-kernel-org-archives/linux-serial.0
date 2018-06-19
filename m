From: Mikko Perttunen <cyndis@kapsi.fi>
Subject: Re: [PATCH 1/8] dt-bindings: tegra186-hsp: Add shared interrupts
Date: Tue, 19 Jun 2018 15:41:05 +0300
Message-ID: <3b5708ef-c82f-c4b2-da50-2cb2afa3edb2@kapsi.fi>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
 <20180508114403.14499-2-mperttunen@nvidia.com>
 <2bed23e6-19d5-66f8-774e-d613a91b1607@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2bed23e6-19d5-66f8-774e-d613a91b1607@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, robh+dt@kernel.org, mark.rutland@arm.com, jassisinghbrar@gmail.com, gregkh@linuxfoundation.org, thierry.reding@gmail.com
Cc: araza@nvidia.com, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 22.05.2018 18:15, Jon Hunter wrote:
> 
> On 08/05/18 12:43, Mikko Perttunen wrote:
>> Non-doorbell interrupts are routed through "shared interrupts". These
>> interrupts can be mapped to various internal interrupt lines. Add
>> interrupt properties for shared interrupts to the tegra186-hsp device
>> tree bindings.
> 
> Reading the Tegra documentation, although the doorbells have dedicated 
> interrupts, it appears that the doorbell interrupts can also be routed 
> via these shared interrupts.

Thanks, I changed the text slightly to account for this.

> 
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>>   Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt | 
>> 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt 
>> b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
>> index b99d25fc2f26..9edcdf82d719 100644
>> --- a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
>> +++ b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
>> @@ -21,6 +21,8 @@ Required properties:
>>       Contains a list of names for the interrupts described by the 
>> interrupt
>>       property. May contain the following entries, in any order:
>>       - "doorbell"
>> +    - "sharedN", where 'N' is a number from zero up to the number of
>> +      external interrupts supported by the HSP instance minus one.
>>       Users of this binding MUST look up entries in the interrupt 
>> property
>>       by name, using this interrupt-names property to do so.
>>   - interrupts
> 
> How is the mapping of shared-mailboxes interrupts to the actual 
> 'sharedN' interrupt managed?

Currently the driver always uses shared0 for mailbox-full interrupt, and 
nothing else, which is what downstream does as well. It's difficult to 
do anything else as we can trample on some other driver's configuration..

> 
> Cheers
> Jon
> 

Thanks,
Mikko
