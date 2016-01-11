From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH -next] tty/serial: atmel: Include module.h to fix build
 failure
Date: Mon, 11 Jan 2016 10:08:03 -0500
Message-ID: <5693C553.7050400@windriver.com>
References: <1452363335-2535-1-git-send-email-linux@roeck-us.net> <20160109182908.GB29967@kroah.com> <20160111083536.GB8070@sudip-pc> <20160111111101.GA18945@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160111111101.GA18945@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2016-01-11 06:11 AM, Guenter Roeck wrote:
> On Mon, Jan 11, 2016 at 02:05:36PM +0530, Sudip Mukherjee wrote:
>> On Sat, Jan 09, 2016 at 10:29:08AM -0800, Greg Kroah-Hartman wrote:
>>> On Sat, Jan 09, 2016 at 10:15:35AM -0800, Guenter Roeck wrote:
>>>> If serial/atmel_serial.c is compiled with devicetree enabled, the
>>>> following build error is observed.
>>>>
>>>> drivers/tty/serial/atmel_serial.c:192:1: warning:
>>>> 	data definition has no type or storage class
>>>> drivers/tty/serial/atmel_serial.c:192:1: error:
>>>> 	type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE'
>>>> drivers/tty/serial/atmel_serial.c:192:1: warning:
>>>> 	parameter names (without types) in function declaration
>>>>
>>>> MODULE_DEVICE_TABLE is used to specify devicetree compatibilities.
>>>>
>>>> Fixes: c39dfebc7798 ("drivers/tty/serial: make serial/atmel_serial.c explicitly non-modular")
>>>> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>> ---
>>>>  drivers/tty/serial/atmel_serial.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>
>>> This hit my tree last night already with commit
>>> 041497eb721ddbdc1e690316976dd8ba7bc136a2, so all should be fine in the
>>> next linux-next release.
>>
>> Hi Guenter,
>> Just a thought. It has happended many times that we both have sent
>> patches to fix the same build fail. Maybe your patch got applied and
>> mine came late or maybe mine was applied and you came late. But I think
>> if we have a separate mailing list where people interested to fix and
>> monitor build failures will be members and we Cc that list whenever we
>> send patch for build fail and then in that case we will know that
>> someone else has already sent a patch for this failure and we can invest
>> the time in some other problem.
>>
> 
> Hi Sudip,
> 
> I agree, it would make sense to have a build(/runtime?)-fixes-only mailing
> list. Question though is how to limit noise on such a list and, of course,
> where and how to set it up. Any thoughts ?

Since most (all?) of these kind of fails are on linux-next, why not
do what everyone else does, and report the fail there and/or ensure
the fix is cc'd there?   Before I waste time trying to fix sth on
linux-next, I always google for the error msg and many times that
leads me to a lkml or linux-next post where it was reported and
fixed already.

Paul.
