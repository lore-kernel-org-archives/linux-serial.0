From: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: Re: [PATCH 0/3] Support MPS2 UART controller
Date: Fri, 6 May 2016 15:43:24 +0100
Message-ID: <572CAD8C.5000102@arm.com>
References: <1461574068-14641-1-git-send-email-vladimir.murzin@arm.com>
 <CAP=VYLopd8erCP9J9cTyZ+YubafKjWi3bHQp-swmyfyn2eZ_Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAP=VYLopd8erCP9J9cTyZ+YubafKjWi3bHQp-swmyfyn2eZ_Ww@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, jslaby@suse.com, Arnd Bergmann <arnd@arndb.de>, sudeep.holla@arm.com, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 06/05/16 15:31, Paul Gortmaker wrote:
> On Mon, Apr 25, 2016 at 4:47 AM, Vladimir Murzin
> <vladimir.murzin@arm.com> wrote:
>> Hi,
>>
>> These patches allow to use UART controller found on MPS2 platform.
> 
> Did you intend this driver to support being modular?  It has a bool Kconfig
> (not tristate) which makes the module_exit dead code.
> 
> If it will always be builtin (with console as primary use case) then you can
> see commit 89ebc27427695bfc1e769f1dd99bd243d332ac7a as a possible
> update suggestion.

Thanks for the pointer, Paul! I'll see how to update the driver and send
a patch after next merge window closed.

Cheers
Vladimir

> 
> P.
> --
> 
>>
>> Following [1], please, consider to merge them into tty/serial tree.
>>
>> [1] https://lkml.org/lkml/2016/4/23/190
>>
>> Thanks!
>>
>> Vladimir Murzin (3):
>>   dt-bindings: document the MPS2 UART bindings
>>   serial: mps2-uart: add MPS2 UART driver
>>   serial: mps2-uart: add support for early console
>>
>>  .../devicetree/bindings/serial/arm,mps2-uart.txt   |   19 +
>>  drivers/tty/serial/Kconfig                         |   13 +
>>  drivers/tty/serial/Makefile                        |    1 +
>>  drivers/tty/serial/mps2-uart.c                     |  625 ++++++++++++++++++++
>>  include/uapi/linux/serial_core.h                   |    3 +
>>  5 files changed, 661 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/serial/arm,mps2-uart.txt
>>  create mode 100644 drivers/tty/serial/mps2-uart.c
>>
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
