From: Patrice CHOTARD <patrice.chotard@st.com>
Subject: Re: [PATCH 1/2] ARM: dts: STi: Fix aliases property name for STi
 boards
Date: Mon, 5 Mar 2018 16:53:23 +0000
Message-ID: <4bf43157-9214-c160-3f69-1e56f8cfdf98@st.com>
References: <1520262025-21088-1-git-send-email-patrice.chotard@st.com>
 <1520262025-21088-2-git-send-email-patrice.chotard@st.com>
 <CABGGiszEcvKHGE54vOXPBUJeReAKbgmrxRyRxNfQQoL6D54GCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CABGGiszEcvKHGE54vOXPBUJeReAKbgmrxRyRxNfQQoL6D54GCw@mail.gmail.com>
Content-Language: en-US
Content-ID: <3A1A3AD27E1B9A4CAF36F84D026FB51B@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "jslaby@suse.com" <jslaby@suse.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Rob

On 03/05/2018 04:28 PM, Rob Herring wrote:
> On Mon, Mar 5, 2018 at 9:00 AM,  <patrice.chotard@st.com> wrote:
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> Since dtc v1.4.6-9-gaadd0b65c987, aliases property name must
>> be lowercase only.
>> This allows to fix following warnings when compiling dtb
>> with W=1 option :
> 
> I'm so glad to see fixes before the dtc update landed in the kernel tree!

;-)

> 
>> arch/arm/boot/dts/stih418-b2199.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
>> arch/arm/boot/dts/stih407-b2120.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
>> arch/arm/boot/dts/stih410-b2260.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
>> arch/arm/boot/dts/stih410-b2120.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
>> ---
>>   arch/arm/boot/dts/stih407-b2120.dts | 4 ++--
>>   arch/arm/boot/dts/stih410-b2120.dts | 4 ++--
>>   arch/arm/boot/dts/stih410-b2260.dts | 4 ++--
>>   arch/arm/boot/dts/stih418-b2199.dts | 4 ++--
>>   4 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/stih407-b2120.dts b/arch/arm/boot/dts/stih407-b2120.dts
>> index c8ad905d0309..fa1186af6574 100644
>> --- a/arch/arm/boot/dts/stih407-b2120.dts
>> +++ b/arch/arm/boot/dts/stih407-b2120.dts
>> @@ -14,7 +14,7 @@
>>          compatible = "st,stih407-b2120", "st,stih407";
>>
>>          chosen {
>> -               bootargs = "console=ttyAS0,115200 clk_ignore_unused";
>> +               bootargs = "console=ttyas0,115200 clk_ignore_unused";
> 
> The kernel change for this is an ABI breakage both DT <-> kernel and
> kernel <-> userspace.
> 
> Really, if you are okay with doing this, you should change it to ttySx IMO.

OK i will use serialN instead

> 
>>                  linux,stdout-path = &sbc_serial0;
> 
> And since you have this, you don't even need the console praram.

Ok, i will remove stdout-path in an additional patch

> 
>>          };
>>
>> @@ -24,7 +24,7 @@
>>          };
>>
>>          aliases {
>> -               ttyAS0 = &sbc_serial0;
>> +               ttyas0 = &sbc_serial0;
> 
> The correct fix is use "serialN" for aliases.

Ok

> 
> I have a check for only known alias names which would give a better
> warning, but David thought it was too restrictive.
> 
>>                  ethernet0 = &ethernet0;
>>          };
>>


Thanks

Patrice
