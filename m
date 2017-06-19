From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v5 3/4] ARM64: dts: meson-gx: use stable UART bindings
 with correct gate clock
Date: Mon, 19 Jun 2017 10:40:12 +0200
Message-ID: <e409b45e-41bc-0c1c-5657-d6f2ef0152f2@baylibre.com>
References: <1497428957-19942-1-git-send-email-narmstrong@baylibre.com>
 <1497428957-19942-4-git-send-email-narmstrong@baylibre.com>
 <m2vanvejlc.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <m2vanvejlc.fsf@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: gregkh@linuxfoundation.org, Helmut Klein <hgkr.klein@gmail.com>, linux-serial@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 06/16/2017 10:57 PM, Kevin Hilman wrote:
> Neil Armstrong <narmstrong@baylibre.com> writes:
> 
>> From: Helmut Klein <hgkr.klein@gmail.com>
>>
>> This patch switches to the stable UART bindings but also add the correct
>> gate clock to the non-AO UART nodes for GXBB and GXL SoCs.
>>
>> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
>> Signed-off-by: Helmut Klein <hgkr.klein@gmail.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 12 +++++-------
>>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 25 +++++++++++++++++++++++++
>>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 25 +++++++++++++++++++++++++
>>  3 files changed, 55 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> index 603491d..86a4018 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> @@ -225,7 +225,7 @@
>>  			};
>>  
>>  			uart_A: serial@84c0 {
>> -				compatible = "amlogic,meson-uart";
>> +				compatible = "amlogic,meson-gx-uart";
> 
> IMO, we should keep both compatibles (the more specific one first.)
> That would allow new DTs to continue to run on older kernels.
> 
> It would also allow this DT change to be completely independent of the
> driver changes.  Otherwise, if I merge this before the driver change are
> merged, we'll have a bunch of boards with no more serial console output.
> 
> Kevin
> 

Hi Kevin,

Sure, no problem with that.

I'll push an update when the bindings + tty fixes are merged somewhere.

Neil
