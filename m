From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] serial: 8250_lpss: Unconditionally set PCI master for Quark
Date: Tue, 10 Jan 2017 01:24:53 +0200
Message-ID: <CAHp75Vd8sj6j1sRQV_h2uPTsKrf74rxfdjaTGYrxeXCRd0X=8w@mail.gmail.com>
References: <1d0224cc-10ee-df69-b383-c687e08ed44d@siemens.com>
 <CAHp75Vf9h51xXU9HguU+XuqLAS4Zs7WWFBNT+rwccTdSWdwpYg@mail.gmail.com>
 <CAHp75VdC_4GUgDzatu2CfRL8nfo4PZMWiV6t=CbU6QVuhZLRmg@mail.gmail.com> <ea0f58b8-6cd0-f990-ab89-799713151e52@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ea0f58b8-6cd0-f990-ab89-799713151e52@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 9, 2017 at 7:11 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2017-01-05 22:56, Andy Shevchenko wrote:
>> On Thu, Jan 5, 2017 at 1:56 AM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>
>> Ah, Jan, perhaps you would like to comment on this one as well
>> http://marc.info/?l=linux-serial&m=148334902916347&w=2
>> ?
>>
>
> http://marc.info/?l=linux-serial&m=148334905916354&w=2 enables MSI, but
> that's only for Denverton, and there it is unconditional. So this is ok.

I think there is potential issue, if DMA driver is not compiled or
probed (by whatever reason) we will have MSI enabled without bus
mastering.
And like you said for sake of not copying wrong pattern for new API,
would be good to move it.

-- 
With Best Regards,
Andy Shevchenko
