From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/2] tty: amba-pl011: fix earlycon register offsets
Date: Tue, 5 Jan 2016 13:45:52 +0000
Message-ID: <568BC910.5050904@arm.com>
References: <1450972189-22639-1-git-send-email-timur@codeaurora.org>
 <20151224164723.GK8644@n2100.arm.linux.org.uk>
 <CAPKp9ubdS+R8U-W+LxYEp_sGxZVBDGBJ48+N7Pw3k9A+=F4pww@mail.gmail.com>
 <20160105123018.GU19062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160105123018.GU19062@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <greg@kroah.com>, Timur Tabi <timur@codeaurora.org>, andrew.jackson@arm.com, andre.przywara@arm.com, linux-serial@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, shijie.huang@arm.com, jslaby@suse.com, jun.nie@linaro.org, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org



On 05/01/16 12:30, Russell King - ARM Linux wrote:
> On Tue, Jan 05, 2016 at 12:12:31PM +0000, Sudeep Holla wrote:
>> Hi Russell,
>>
>> On Thu, Dec 24, 2015 at 4:47 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> On Thu, Dec 24, 2015 at 09:49:48AM -0600, Timur Tabi wrote:
>>>> The REG_x macros are indices into a table, not register offsets.  Since
>>>> earlycon does not have access to the vendor data, we can currently only
>>>> support standard ARM PL011 devices.
>>>>
>>>> Signed-off-by: Timur Tabi <timur@codeaurora.org>
>>>
>>> Please credit me with the change; this was obviously a change I made
>>> when I posted the updated patches, which Greg had failed to take
>>> instead of the original set.  Thanks.
>>>
>>
>> I don't see this patch in linux-next. Without this it fails to boot(panics) on
>> ARM64 when earlycon is enabled.
>

[...]

>
> As far as 4.4 goes, I think it's fate was sealed when Greg took the
> wrong set of patches.  It's Greg's problem to sort out now.
>

Since it's boot failure, it should be considered as bug fix and merged.

>> Also I think this fix might not be correct
>> for ZTE pl011, though it works for ST and standard PL011.
>
> Yes, earlycon won't work for ZTE PL011.  This isn't a big problem at
> the moment, because the patch set doesn't wire up the ZTE PL011 itself.

Yes, I observed that, but still mentioned it just to check if that was
the reason for holding this patch. Thanks for the clarification.

> The reason there is that I'm saying no to using a platform device; I
> really do not like drivers which end up with multiple different probe
> and remove methods.  The AMBA PL011 driver is an AMBA primecell driver,
> and it sits on the AMBA primecell bus, not the platform bus.
>
> What I want to see is some way of having the ZTE PL011 appearing on the
> AMBA bus, which means we need to come up with some way to deal with
> primecells which don't have an ID.  That is an open issue, as is how
> to deal with earlycon.
>

Understood and thanks for the detailed explanation.

-- 
Regards,
Sudeep
