From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: regression: 3a878c430fd6 ("tty: serial: msm: Add TX DMA support")
 drops data
Date: Sat, 23 Apr 2016 10:24:00 -0700
Message-ID: <571BAFB0.1080303@gmail.com>
References: <5716BDF1.1010407@gmail.com> <EEBBF78A-33BB-4ACD-8CBF-285E1149FB9F@gmail.com> <5717B2CA.3020206@gmail.com> <57182635.5070606@gmail.com> <CAHp75Vdu6+qLHe9tTK5BE3ec5Mvz5Z0e4DvLc8ewjjVbSs-BdQ@mail.gmail.com>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vdu6+qLHe9tTK5BE3ec5Mvz5Z0e4DvLc8ewjjVbSs-BdQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Ivanov <iivanov.xz@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Peter Hurley <peter@hurleysoftware.com>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>, Andy Gross <agross@codeaurora.org>, David Brown <davidb@codeaurora.org>, srinivas.kandagatla@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 4/21/2016 1:42 PM, Andy Shevchenko wrote:
> On Thu, Apr 21, 2016 at 4:00 AM, Frank Rowand <frowand.list@gmail.com> wrote:
>> On 4/20/2016 9:48 AM, Frank Rowand wrote:

< snip >

>> I'm not sure if the driver was in DMA or PIO mode, both
>> before the change and after.  This seems like a rather
>> important question to answer, so I'll try to verify
>> that tonight.

I was in PIO mode.

I found the problem and submitted a fix.

   [PATCH 0/2] tty: serial: msm_serial regression and add info message
   [PATCH 1/2] tty: serial: msm_serial regression fix data corruption
   [PATCH 2/2] tty: serial: msm_serial add info message


< snip >

-Frank
