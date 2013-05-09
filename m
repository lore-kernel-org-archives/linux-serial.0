From: Srinivas KANDAGATLA <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
Subject: Re: [RFC 3/8] mfd:syscon: Introduce claim/read/write/release APIs
Date: Thu, 09 May 2013 15:00:16 +0100
Message-ID: <518BABF0.7040201@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022272-2241-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081650.23264.arnd@arndb.de>
 <20130508150141.GA5057@opensource.wolfsonmicro.com> <518A8E6C.6070907@st.com>
 <20130509095143.GB7478@sirena.org.uk> <518B8F49.5020902@st.com>
 <20130509132600.GA3200@sirena.org.uk>
Reply-To: srinivas.kandagatla-qxv4g6HH51o@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130509132600.GA3200-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
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
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stuart Menefy <stuart.menefy-qxv4g6HH51o@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 09/05/13 14:26, Mark Brown wrote:
> On Thu, May 09, 2013 at 12:58:01PM +0100, Srinivas KANDAGATLA wrote:
> 
>> Currently, we have two bits of information which come from device trees.
>> 1> The syscon bank/group definition itself.
>> 2> syscon register offsets and bits information to the drivers.
> 
>> These are the 2 things which keep changing per each SOC.
> 
>> There is no other way to pass this information to the drivers other than
>> passing them as part of their own device node and syscon node.
> 
> Sure there is, for example the drivers could have this information
> internally as part of knowing which device they're working with or they
> could take advantage of some patterns in the register map to store some
> higher level information that they use to configure.
> 
Some of layouts of the sysconf registers are totally changed for each SOC.

Looking at driver by driver maybe some drivers can take advantage of the
patterns, but Am not sure if this will be a sustainable solution for all
the drivers.

The big disadvantage of this approach is that
- Every driver has to be touched for new SOC,
- Secondly the drivers will end up having more of such information than
code over a time.

>>>  and to the extent that it is sensible it feels like something
>>> which might be useful with any device using register maps, not just
>>> syscon.
> 
>> If you think this is going to be useful for other drivers, Am happy to
>> move this out of syscon to regmap something like adding
>> of_regmap_field_claim/regmap_field_claim/regmap_field_read/regmap_field_write/regmap_field_release
>> functions.
> 
>> so any exiting drivers can still use the old syscon API to get the
>> regmap instance.
>> Alternatively they can use the new regmap APIs directly.
> 
> Well, I'd need to see the code to decide if it was sane but I do think
> that if this is a good approach it's not syscon specific.  Anything like
> this needs to be independent of DT too since not all architectures use
> DT.
In the suggested approach, the API supports, both DT and non-DT style.

for DT style user can use.
of_regmap_field_claim -> regmap_field_read -> regmap_field_write-
->regmap_field_release

and for NON-DT user can use
regmap_field_claim  -> regmap_field_read -> regmap_field_write-
->regmap_field_release


thanks,
srini


> 
