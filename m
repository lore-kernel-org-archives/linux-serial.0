From: Paul Menzel <pmenzel+linux-serial@molgen.mpg.de>
Subject: Is 115200 still the maximum baudrate?
Date: Thu, 2 Nov 2017 16:42:56 +0100
Message-ID: <d712888f-3b91-76c5-b949-407b0c072bcf@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Dear Linux folks,


The Linux serial console documentation [1] says that 115200 is the 
maximum supported baudrate.

 > The maximum baudrate is 115200.

Is that still accurate? If yes, where should I look to support higher 
values?


Kind regards,

Paul


[1] https://www.kernel.org/doc/html/v4.13/admin-guide/serial-console.html
