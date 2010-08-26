From: Jason Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH RESEND 0/2] two serial_core suspend/resume fixes
Date: Thu, 26 Aug 2010 16:50:36 +0800
Message-ID: <4C762ADC.8080309@gmail.com>
References: <1282374882-6651-1-git-send-email-jason77.wang@gmail.com>	 <1282593975.3526.9.camel@utx.lan>	 <AANLkTikZgAMvODoFB9O9Mrb98f_xMatQfkb+2dgcrGJn@mail.gmail.com>	 <1282640491.4910.35.camel@utx.lan>  <4C748E0E.8040308@windriver.com>	 <1282733489.5085.35.camel@utx.lan> <1282766435.5085.178.camel@utx.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:58938 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445Ab0HZIrX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Aug 2010 04:47:23 -0400
In-Reply-To: <1282766435.5085.178.camel@utx.lan>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: jason wang <jason77.wang@gmail.com>, gregkh@suse.de, alan@linux.intel.com, arnd@arndb.de, linux-serial@vger.kernel.org

Stanislav Brabec wrote:
> Stanislav Brabec wrote:
>   
>> wanghui wrote:   
>>     
>>> For this situation, i guess you use a single serial port both as a
>>> printk console and as a login tty.
>>>       
>> Yes, I did exactly that.
>>     
>
> Well, I just succeeded with experiments.
> Changing
> if (console_suspend_enabled || !uart_console(uport)) {
> in resume process just above the line
> /* Protected by port mutex for now */
> to
> if (1) {
> makes resume working with no_console_suspend again. So one of lines
> inside does something important.
>
> Even then, the log is incomplete. dmesg shows more, but even it lacks
> printk output from inside of if (1).
>
>   
Hah, :), i guess the ops->set_termios() resume your uart in the end.
Why lost some logs, i will try to reproduce your test.


