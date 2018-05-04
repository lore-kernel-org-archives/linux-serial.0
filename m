From: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Subject: Re: [PATCH] serial: imx: enable IMX21_UCR3_RXDMUXSEL for non-dte-mode
Date: Fri, 4 May 2018 11:59:42 +0800
Message-ID: <162654a7-5add-2ea4-b947-783189535091@gtsys.com.hk>
References: <1524186479-25315-1-git-send-email-chris.ruehl@gtsys.com.hk>
 <20180420061316.sakoupltqxn2qhfr@pengutronix.de>
 <ca240b4a-aa42-b747-9bab-49b18290ca49@gtsys.com.hk>
 <20180503201317.GA19401@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180503201317.GA19401@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

>>
>> The IMX serial driver is broken in the 4.9.x tree since 4.9.89.
>> Uwe's patch
>>
>> 6df765dca378bddf994cfd2044acafa501bd800f
>>
>> please apply to clear the situation.
>>
>> I know you very busy! -
> 
> It's best to email stable@vger.kernel.org for stuff like this, as I
> almost missed it...
> 
> Now queued up.
> 
> greg k-h

Thanks!
will follow up and cc the stable@ next time.

Chris
