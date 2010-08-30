From: Jason Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH RESEND 0/2] two serial_core suspend/resume fixes
Date: Mon, 30 Aug 2010 13:59:26 +0800
Message-ID: <4C7B48BE.7050304@gmail.com>
References: <1282374882-6651-1-git-send-email-jason77.wang@gmail.com>	 <1282593975.3526.9.camel@utx.lan>	 <AANLkTikZgAMvODoFB9O9Mrb98f_xMatQfkb+2dgcrGJn@mail.gmail.com>	 <1282640491.4910.35.camel@utx.lan>  <4C748E0E.8040308@windriver.com>	 <1282733489.5085.35.camel@utx.lan> <1282766435.5085.178.camel@utx.lan>	 <4C762ADC.8080309@gmail.com> <1283120257.17967.24.camel@utx.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:62565 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920Ab0H3F4M (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 30 Aug 2010 01:56:12 -0400
In-Reply-To: <1283120257.17967.24.camel@utx.lan>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: Jason Wang <jason77.wang@gmail.com>, gregkh@suse.de, alan@linux.intel.com, arnd@arndb.de, linux-serial@vger.kernel.org

Stanislav Brabec wrote:
> Jason Wang wrote:
>
>   
>> Hah, :), i guess the ops->set_termios() resume your uart in the end.
>> Why lost some logs, i will try to reproduce your test.
>>     
>
> I'll try and ask you to test verify that my new patch does not break
> your platform.
>
>   
Sure, i look forward to your new patch.
> Anyway, now I know, what I did bad. Your patch makes things better on
> some platforms and does not break others.
>
> Acked-by: Stanislav Brabec <sbrabec@suse.cz>
>
>   
Thanks.

