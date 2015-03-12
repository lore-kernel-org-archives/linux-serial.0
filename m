From: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v2 10/10] drivers: PL011: add support for the ARM SBSA
 generic UART
Date: Thu, 12 Mar 2015 13:58:58 +0000
Message-ID: <55019BA2.1090404@arm.com>
References: <1425491994-23913-1-git-send-email-andre.przywara@arm.com>
 <1425491994-23913-11-git-send-email-andre.przywara@arm.com>
 <20150312105210.GK8656@n2100.arm.linux.org.uk> <550197F5.1020107@arm.com>
 <20150312134921.GR8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150312134921.GR8656@n2100.arm.linux.org.uk>
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
Cc: "rob.herring@linaro.org" <rob.herring@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, Dave P Martin <Dave.Martin@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 12/03/15 13:49, Russell King - ARM Linux wrote:
> On Thu, Mar 12, 2015 at 01:43:17PM +0000, Andre Przywara wrote:
>> Hi Russel,
>>
>> thanks a lot for looking at the patches!
>>
>> On 12/03/15 10:52, Russell King - ARM Linux wrote:
>>> On Wed, Mar 04, 2015 at 05:59:54PM +0000, Andre Przywara wrote:
>>>> +module_platform_driver(arm_sbsa_uart_platform_driver);
>>>
>>> No need to open code the initialisation, rather than using the
>>> module_*_driver() helper macros to avoid the problem which Dave mentioned.
>>>
>>> These macros are only there to avoid having to write out the same boiler
>>> plate in loads of simple drivers.  As soon as a driver has more than one
>>> device driver structure in it, it needs to be open coded.
>>
>> Actually I prepared this already for the ACPI guys, which want to stuff
>> their ACPI table match function in there - I think then we need the open
>> coded version. So if you don't mind too much, I'd like to keep it like
>> this and hope for someone to actually use it ;-)
> 
> Either your statement is ambiguous, or I'm not understanding you.
> 
> You can't "keep it like this" where "this" is the above code.  The
> above will fail if the driver is built as a module, and cause a build
> time error.  That is not acceptable.

Oh, you are right, I was forgetting about that one, sorry.
I meant I'd rather leave it open coded, but of course I will fix the
module issue.

Cheers,
Andre.
