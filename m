From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: Re: [PATCH v2 02/11] clocksource:global_timer: Add ARM global timer
 support.
Date: Tue, 11 Jun 2013 15:05:14 +0100
Message-ID: <51B72E9A.6070006@st.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856087-6452-1-git-send-email-srinivas.kandagatla@st.com>
 <CACRpkdbQCRKBzRF4HzNsXHwXCLJJcFZ9T36GPmmYsnX1OfgGRg@mail.gmail.com>
 <51B5D7A6.1020101@st.com>
Reply-To: srinivas.kandagatla@st.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51B5D7A6.1020101@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, srinivas.kandagatla@st.com, Will Deacon <will.deacon@arm.com>, Mike Turquette <mturquette@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Stephen Gallimore <stephen.gallimore@st.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, Stuart Menefy <stuart.menefy@st.com>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger
List-Id: linux-serial@vger.kernel.org

On 10/06/13 14:41, Srinivas Kandagatla wrote:
> On 10/06/13 14:13, Linus Walleij wrote:
>> On Mon, Jun 10, 2013 at 11:21 AM, Srinivas KANDAGATLA
>> Isn't it better to pass a struct device_node *np around and have that as
>> NULL in the non-DT boot path?
> I will try it and see how it will look.

I did try the change you suggested regarding passing struct device_node
*np around for both DT and non-DT boot paths.

Doing this is not adding any value to the driver, because
 1. Currently the driver only support DT boot paths, in my previous RFC
patches, Arnd suggested to get rid of the header as all platforms are DT
now.
 2. Passing device_node around is not adding any value w.r.t reducing
code or any thing.

So, I think I will stay with what is there originally, unless you have a
strong reason.

Thanks,
srini

> 
> Thanks,
> srini
>>
>> (Maybe somebody in the community asked you to do this, then I
>> will live with it.)
> 
>>
>> Yours,
>> Linus Walleij
>>
>>
> 
