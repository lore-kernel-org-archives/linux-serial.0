From: Jon Masters <jonathan@jonmasters.org>
Subject: Re: The console log is doubled if earlycon is enabled
Date: Mon, 21 Dec 2015 02:54:39 -0500
Message-ID: <5677B03F.1030506@jonmasters.org>
References: <CAK7LNAT5L2uxJ6i-QEYqw9qFLyvADu_E0F5VVTOPqyHbLodTCg@mail.gmail.com> <20151128000451.GB22297@kroah.com> <CAK7LNARFa8Q1t6RwwQVhTrtXJxnJBQw8QHnbpfNfHouEiGdK0w@mail.gmail.com> <20151130171034.GA14366@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151130171034.GA14366@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robherring2@gmail.com>
List-Id: linux-serial@vger.kernel.org

On 11/30/15, 12:10 PM, Greg Kroah-Hartman wrote:
> On Mon, Nov 30, 2015 at 02:53:49PM +0900, Masahiro Yamada wrote:
>> 2015-11-28 9:04 GMT+09:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
>>> On Fri, Nov 27, 2015 at 07:21:06PM +0900, Masahiro Yamada wrote:
>>>> Hi,
>>>>
>>>>
>>>> If I add "earlycon" to the kernel parameter, the log message
>>>> on the earlycon is also displayed to the regular console.
>>>> In other words, the same log messages are displayed twice.
>>>>
>>>> I noticed this problem on v4.4-rc1.
>>>> It has not been fixed in the mainline yet, I think.
>>>>
>>>> Anybody who has a clue?
>>>> (I have not done git-bisect yet.)
>>>
>>> Can you do 'git bisect'?
>>
>>
>> The same problem happened on v4.3.
>> (I think I just did not notice the problem before.)
>>
>> So, the bad commit is not in the last merge window.
>
> Is it ok for 4.2?  4.1?  Finding out where this started to "fail" would
> be good to know...

Just as a data point, on our internal systems earlycon is known good in 
combination with regular console (provided by SPCR ACPI patch) on 4.2.

Jon.
