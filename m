From: Srinivas KANDAGATLA <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH v2 06/11] ARM:stixxxx: Add STiH415 SOC support
Date: Fri, 14 Jun 2013 08:31:56 +0100
Message-ID: <51BAC6EC.8000703@st.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856381-6644-1-git-send-email-srinivas.kandagatla@st.com>
 <CACRpkdZ-xnDO+bte4tyKDWwY4A_qWUhLru3dUmuY9MQwseP3uQ@mail.gmail.com>
 <51B6011E.1060909@st.com>
Reply-To: srinivas.kandagatla-qxv4g6HH51o@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <51B6011E.1060909-qxv4g6HH51o@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: srinivas.kandagatla-qxv4g6HH51o@public.gmane.org
Cc: Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Stephen Gallimore <stephen.gallimore-qxv4g6HH51o@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stuart Menefy <stuart.menefy-qxv4g6HH51o@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On 10/06/13 17:38, Srinivas Kandagatla wrote:
>> +++ b/arch/arm/boot/dts/stixxxx-pincfg.h
>> >> @@ -0,0 +1,94 @@
>> >> +#ifndef _STIXXXX_PINCFG_H_
>> >> +#define _STIXXXX_PINCFG_H_
>> >> +
>> >> +/* Alternate functions */
>> >> +#define ALT1   1
>> >> +#define ALT2   2
>> >> +#define ALT3   3
>> >> +#define ALT4   4
>> >> +#define ALT5   5
>> >> +#define ALT6   6
>> >> +#define ALT7   7
>> 
>> Why is this part of the DT definitions? In the pinctrl world this
>> is an intrinsic detail on how groups and functions are associated,
>> not something that you hard-code into the device tree. The
>> device tree should state how to combine functions with groups
>> and those will be strings, not numerals.

Hi Linus,
I would like to get correct understanding of the point your raised here.
I use these ALT function values in "st,function" property for pinctrl
group as shown in this simple example:

pinctrl_sbc_serial1:sbc_serial1 {
       st,function = <ALT3>;
       st,pins {
              tx      = <&PIO2 6 OUT>;
              rx      = <&PIO2 7 IN>;
       };
};

If I do something like what rockchip pinctrl did the pinctrl group will
look like.

pinctrl_sbc_serial1:sbc_serial1 {
       st,pins {
              tx      = <&PIO2 6 OUT ALT3>;
              rx      = <&PIO2 7 IN ALT3>;
       };
};

Is this the right way to do it?

Thanks,
srini
