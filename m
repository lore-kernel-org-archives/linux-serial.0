From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH -next] tty/serial: atmel: Include module.h to fix build
 failure
Date: Tue, 19 Jan 2016 22:27:12 -0800
Message-ID: <569F28C0.9050605@roeck-us.net>
References: <20160109182908.GB29967@kroah.com>
 <20160111083536.GB8070@sudip-pc> <20160111111101.GA18945@roeck-us.net>
 <5693C553.7050400@windriver.com> <5695E207.9080309@roeck-us.net>
 <1452663850.8586.3.camel@perches.com> <20160113103246.GB26117@sudip-pc>
 <569D1496.5080402@roeck-us.net> <20160118170423.GA25394@sudip-laptop>
 <569D1E2E.4070209@roeck-us.net> <20160120055123.GA3747@sudip-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160120055123.GA3747@sudip-pc>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Joe Perches <joe@perches.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, postmaster <postmaster@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 01/19/2016 09:51 PM, Sudip Mukherjee wrote:
> On Mon, Jan 18, 2016 at 09:17:34AM -0800, Guenter Roeck wrote:
>> On 01/18/2016 09:04 AM, Sudip Mukherjee wrote:
>>> On Mon, Jan 18, 2016 at 08:36:38AM -0800, Guenter Roeck wrote:
>>>> On 01/13/2016 02:32 AM, Sudip Mukherjee wrote:
>>>>> On Tue, Jan 12, 2016 at 09:44:10PM -0800, Joe Perches wrote:
>>>>>> On Tue, 2016-01-12 at 21:35 -0800, Guenter Roeck wrote:
>>>>>>> On 01/11/2016 07:08 AM, Paul Gortmaker wrote:
>>>>>>>> On 2016-01-11 06:11 AM, Guenter Roeck wrote:
>>>>>>>>> On Mon, Jan 11, 2016 at 02:05:36PM +0530, Sudip Mukherjee wrote:
>>>>>>>>>> On Sat, Jan 09, 2016 at 10:29:08AM -0800, Greg Kroah-Hartman wrote:
>>>>>>>>>>> On Sat, Jan 09, 2016 at 10:15:35AM -0800, Guenter Roeck wrote:
>>>>>>>>>>>> If serial/atmel_serial.c is compiled with devicetree enabled, the
>>>>> <snip>
>>>>>>>
>>>>>>> Sudip, one option would be to set up a semi-private mailing list.
>>>>>>> My build tests now have a dedicated virtual host (kerneltests.org).
>>>>>>> I could set up a managed list there.
>>>>>>
>>>>>> Perhaps it'd be better to have something like linux-build-failures@vger.kernel.org
>>>>>
>>>>> yes, much better. But if me and Guenter are the only two members of that
>>>>> list then it will not look nice. :)
>>>>>
>>>>
>>>> How about just using kernel-testers@vger.kernel.org ? That list already exists and,
>>>> for all practical purposes, has been abandoned.
>>>
>>> Great. I am subscribing to it.
>>>
>>
>> Let's check on the list first. I'll send am e-mail.
>
> I guess no reply means we can use the list...
>

Let's wait until tomorrow; then I'll try to reach the vger majordomo maintainer again
as well as the vger postmaster. We'll need something from there - at the very least
we'll need to get a new list owner. Of course, it would help if someone listening in
to this thread knows how to contact an actual person controlling vger.kernel.org.

Guenter
