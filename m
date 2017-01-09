From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] serial: 8250_lpss: Unconditionally set PCI master for
 Quark
Date: Mon, 9 Jan 2017 18:11:05 +0100
Message-ID: <ea0f58b8-6cd0-f990-ab89-799713151e52@siemens.com>
References: <1d0224cc-10ee-df69-b383-c687e08ed44d@siemens.com>
 <CAHp75Vf9h51xXU9HguU+XuqLAS4Zs7WWFBNT+rwccTdSWdwpYg@mail.gmail.com>
 <CAHp75VdC_4GUgDzatu2CfRL8nfo4PZMWiV6t=CbU6QVuhZLRmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VdC_4GUgDzatu2CfRL8nfo4PZMWiV6t=CbU6QVuhZLRmg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 2017-01-05 22:56, Andy Shevchenko wrote:
> On Thu, Jan 5, 2017 at 1:56 AM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Wed, Jan 4, 2017 at 10:48 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>> MSI needs it as well.
>>>
>>> Should have no practical impact, though, as DMA is always available on
>>> the Quark. But given the few users of pci_alloc_irq_vectors so far, this
>>> incorrect pattern may spread otherwise.
>>
>> This looks valid, but let me review it later, need some sleep.
>>
> 
> Ah, Jan, perhaps you would like to comment on this one as well
> http://marc.info/?l=linux-serial&m=148334902916347&w=2
> 
> ?
> 

http://marc.info/?l=linux-serial&m=148334905916354&w=2 enables MSI, but
that's only for Denverton, and there it is unconditional. So this is ok.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
