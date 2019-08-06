From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [RFCv2 0/9] dt-bindings: first tentative of conversion to yaml
 format
Date: Tue, 6 Aug 2019 09:42:19 +0200
Message-ID: <4e87b12f-ef92-49d8-1e1d-9bc5ba5c3c8d@baylibre.com>
References: <20190805120320.32282-1-narmstrong@baylibre.com>
 <CAL_JsqJzwtSXX0nrS7RBP8u-e=16SiWOBjLrvy8Amc08PfpXag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_JsqJzwtSXX0nrS7RBP8u-e=16SiWOBjLrvy8Amc08PfpXag@mail.gmail.com>
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
To: Rob Herring <robh+dt@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, linux-spi <linux-spi@vger.kernel.org>, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, linux-amlogic@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Rob,

On 05/08/2019 23:51, Rob Herring wrote:
> On Mon, Aug 5, 2019 at 6:03 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> This is a first tentative to convert some of the simplest Amlogic
>> dt-bindings to the yaml format.
>>
>> All have been tested using :
>> $ make ARCH=arm64 dtbs_check
>>
>> Issues with the amlogic arm64 DTs has already been identified thanks
>> to the validation scripts. The DT fixes will be pushed once these yaml
>> bindings are acked.
>>
>> Changes since rfc v1:
>> - Fixed bindings according to Rob's comments
>> - Added commit log
>> - renamed yaml files using amlogic prefix
>>
>> Neil Armstrong (9):
>>   dt-bindings: mailbox: meson-mhu: convert to yaml
>>   dt-bindings: rng: amlogic,meson-rng: convert to yaml
>>   dt-bindings: spi: meson: convert to yaml
>>   dt-bindings: reset: amlogic,meson-reset: convert to yaml
>>   dt-bindings: arm: amlogic: amlogic,meson-gx-ao-secure: convert to yaml
>>   dt-bindings: phy: meson-g12a-usb2-phy: convert to yaml
>>   dt-bindings: phy: meson-g12a-usb3-pcie-phy: convert to yaml
>>   dt-bindings: serial: meson-uart: convert to yaml
>>   dt-bindings: watchdog: meson-gxbb-wdt: convert to yaml
> 
> For the series,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> What's your merge plan? Do you want me to take the whole series?

I planned to split them for each subsystem, but it may be much simpler
if you take the whole serie.

Neil

> 
> Rob
> 
