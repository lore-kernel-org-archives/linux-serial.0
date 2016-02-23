From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/8] arm64: move acpi/dt decision earlier in boot process
Date: Tue, 23 Feb 2016 15:37:26 +0100
Message-ID: <56CC6EA6.4020909@gmail.com>
References: <1456148818-26257-1-git-send-email-aleksey.makarov@linaro.org>
 <1456148818-26257-2-git-send-email-aleksey.makarov@linaro.org>
 <56CB2D0D.3090408@gmail.com>
 <20160223135731.GA24781@xora-haswell.xora.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160223135731.GA24781@xora-haswell.xora.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Graeme Gregory <gg@slimlogic.co.uk>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, linux-acpi@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Graeme Gregory <graeme.gregory@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Leif Lindholm <leif.lindholm@linaro.org>, Christopher Covington <cov@codeaurora.org>, linux-serial@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Al Stone <ahs3@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org



On 23/02/16 14:57, Graeme Gregory wrote:
> On Mon, Feb 22, 2016 at 04:45:17PM +0100, Matthias Brugger wrote:
>>
>>
>> On 22/02/16 14:46, Aleksey Makarov wrote:
>>> From: Leif Lindholm <leif.lindholm@linaro.org>
>>>
>>> In order to support selecting earlycon via either ACPI or DT, move
>>> the decision on whether to attempt ACPI configuration into the
>>> early_param handling. Then make acpi_boot_table_init() bail out if
>>> acpi_disabled.
>>>
>>> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
>>> ---
>>>   arch/arm64/kernel/acpi.c | 54 ++++++++++++++++++++++++++----------------------
>>>   1 file changed, 29 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>>> index d1ce8e2..7a944f7 100644
>>> --- a/arch/arm64/kernel/acpi.c
>>> +++ b/arch/arm64/kernel/acpi.c
>>> @@ -44,6 +44,19 @@ EXPORT_SYMBOL(acpi_pci_disabled);
>>>   static bool param_acpi_off __initdata;
>>>   static bool param_acpi_force __initdata;
>>>
>>> +static int __init dt_scan_depth1_nodes(unsigned long node,
>>> +				       const char *uname, int depth,
>>> +				       void *data)
>>> +{
>>> +	/*
>>> +	 * Return 1 as soon as we encounter a node at depth 1 that is
>>> +	 * not the /chosen node.
>>> +	 */
>>> +	if (depth == 1 && (strcmp(uname, "chosen") != 0))
>>> +		return 1;
>>> +	return 0;
>>> +}
>>> +
>>>   static int __init parse_acpi(char *arg)
>>>   {
>>>   	if (!arg)
>>> @@ -57,23 +70,27 @@ static int __init parse_acpi(char *arg)
>>>   	else
>>>   		return -EINVAL;	/* Core will print when we return error */

If argument of parse_acpi is neither "off" nor "force" we return with 
-EINVAL here. Actually parse_acpi will be only called if we pass "acpi=" 
as kernel parameter. Therefor we can get rid of "acpi=off" as this is 
the _new_ standard. IMHO we should introduce "acpi=on" if we really want 
to change the standard behavior.

>>>
>>> -	return 0;
>>> -}
>>> -early_param("acpi", parse_acpi);
>>> +	/*
>>> +	 * Enable ACPI instead of device tree unless
>>> +	 * - ACPI has been disabled explicitly (acpi=off), or
>>> +	 * - the device tree is not empty (it has more than just a /chosen node)
>>> +	 *   and ACPI has not been force enabled (acpi=force)
>>> +	 */
>>> +	if (param_acpi_off ||
>>> +	    (!param_acpi_force && of_scan_flat_dt(dt_scan_depth1_nodes, NULL)))
>>> +		return 0;

Or param_acpi_off is true or param_acpi_force is true, the depth of the 
DT has no influence.

>>>
>>> -static int __init dt_scan_depth1_nodes(unsigned long node,
>>> -				       const char *uname, int depth,
>>> -				       void *data)
>>> -{
>>>   	/*
>>> -	 * Return 1 as soon as we encounter a node at depth 1 that is
>>> -	 * not the /chosen node.
>>> +	 * ACPI is disabled at this point. Enable it in order to parse
>>> +	 * the ACPI tables and carry out sanity checks
>>>   	 */
>>> -	if (depth == 1 && (strcmp(uname, "chosen") != 0))
>>> -		return 1;
>>> +	enable_acpi();
>>> +
>>
>> So we only enable ACPI if we pass acpi=force as kernel parameter?
>> I'm not sure if this is what you wanted to do.
>>
>
> The current preference from ARM64 maintainers was that is both ACPI
> tables and a DT were presented then DT should take precedence.
>
> With no DT provided the code should use ACPI.

 From my understanding in this patch that can never happen.

On which version is this set based on?
I'm looking on v4.5-rc5 ATM.

Regards,
Matthias
