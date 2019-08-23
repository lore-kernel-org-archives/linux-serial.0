From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: Re: [PATCH V1 1/1] serial: 8250_pci: Add F81504A series Support
Date: Fri, 23 Aug 2019 09:26:58 +0800
Message-ID: <b15b0504-91d3-a147-0613-5c8a4749e74d@gmail.com>
References: <1565933249-23076-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <20190816112644.GF30120@smile.fi.intel.com>
 <8e052919-b012-ff3f-f108-380d1ce5f7e7@gmail.com>
 <20190822211511.GA11893@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822211511.GA11893@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jslaby@suse.com, jay.dolan@accesio.com, hslester96@gmail.com, je.yen.tam@ni.com, lkp@intel.com, kai.heng.feng@canonical.com, heikki.krogerus@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi,

Greg KH 於 2019/8/23 上午 05:15 寫道:
>> Andy Shevchenko 於 2019/8/16 下午 07:26 寫道:
>>> We have 8250_fintek.
>>> Isn't it a right place to add these?
>>>
>>
>> The 8250_fintek implements PNP device with id PNP0501.
>> Should I also implements PCIe device in this file?
> 
> Does it use the same logic?  If so, that makes sense, but if you can not
> share anything, then no, it does not make sense.
> 

It's same with old series F81504/508/512 and the old series had
implement in 8250_pci.c (pbn_fintek_4/pbn_fintek_8/pbn_fintek_12).
So I decide implements the new series in 8250_pci.c


Thanks
-- 
With Best Regards,
Peter Hong
