From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: Re: [PATCH v2 03/11] regmap: Add regmap_field APIs
Date: Tue, 11 Jun 2013 12:36:17 +0100
Message-ID: <51B70BB1.6040703@st.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856118-6503-1-git-send-email-srinivas.kandagatla@st.com>
 <20130611104841.GX1403@sirena.org.uk>
Reply-To: srinivas.kandagatla@st.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130611104841.GX1403@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux@arm.linux.org.uk, Samuel Ortiz <sameo@linux.intel.com>, Alexander Shiyan <shc_work@mail.ru>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree-discuss@lists.ozlabs.org, Stephen Gallimore <stephen.gallimore@st.com>, Rob Herring <rob.herring@calxeda.com>, linux-kernel@vger.kernel.org, Stuart Menefy <stuart.menefy@st.com>, "David S. Miller" <davem@davemloft.net>, John Stultz <john.stultz@linaro.org>, linux-serial@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, Mauro Carvalho Chehab <mchehab@redhat.com>
List-Id: linux-serial@vger.kernel.org

On 11/06/13 11:48, Mark Brown wrote:
> On Mon, Jun 10, 2013 at 10:21:58AM +0100, Srinivas KANDAGATLA wrote:
>> It is common to access regmap registers at bit level, using
>> regmap_update_bits or regmap_read functions, however the end user has to
>> take care of a mask or shifting. This becomes overhead when such use
>> cases are high. Having a common function to do this is much convenient
>> and less error prone.
> 
> So this looks basically good.  A couple of smallish nits below, if you
> could respin I'll apply this on a branch so it can be pulled in as
> dependency for the other things that use it.
> 
Thankyou for the comments,
I will fix it and send a v3 patch.

>> +	regmap_field_init(rm_field, regmap, reg_field);
>> +
>> +	return rm_field;
>> +
>> +}
>> +EXPORT_SYMBOL_GPL(devm_regmap_field_alloc);
>> +/**
>> + * regmap_field_alloc(): Allocate and initialise a register field
> 
> Needs a blank line between the two functions.
> 
>> +#include <linux/device.h>
>> +#include <linux/slab.h>
> 
>> +static inline void regmap_field_free(struct regmap_field *field)
>> +{
>> +	kfree(field);
>> +}
> 
>> +static inline void devm_regmap_field_free(struct device *dev,
>> +	struct regmap_field *field)
>> +{
>> +	devm_kfree(dev, field);
>> +}
> 
> Probably not worth inlining these, just put them in the code.
> 
> 
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
