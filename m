From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [v7] serial: 8250_dw: Add support for big-endian MMIO accesses
Date: Wed, 9 Dec 2015 16:18:33 +0200
Message-ID: <CAHp75Vcv36kcDpeKPw9JrXjBb5JOaNNaq4YH4aKDQ05_Dq1ncA@mail.gmail.com>
References: <1444113590-19722-1-git-send-email-noamc@ezchip.com>
	<1444121610-11832-1-git-send-email-noamc@ezchip.com>
	<1444121610-11832-2-git-send-email-noamc@ezchip.com>
	<20151018040614.GA15152@kroah.com>
	<DB5PR02MB11415C0130C759F96183C0E0D63B0@DB5PR02MB1141.eurprd02.prod.outlook.com>
	<20151018055745.GA31909@kroah.com>
	<DB5PR02MB1141E24EEA35765AA845EDB4D6080@DB5PR02MB1141.eurprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DB5PR02MB1141E24EEA35765AA845EDB4D6080@DB5PR02MB1141.eurprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "jslaby@suse.com" <jslaby@suse.com>, "peter@hurleysoftware.com" <peter@hurleysoftware.com>, "fransklaver@gmail.com" <fransklaver@gmail.com>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "vgupta@synopsys.com" <vgupta@synopsys.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Dec 9, 2015 at 12:57 AM, Noam Camus <noamc@ezchip.com> wrote:
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Sunday, October 18, 2015 8:57 AM
>
>> Please make it against my tty-testing branch of tty.git on
> git.kernel.org, that is the issue here, you are working against a
> "clean" tree, not one with all of the other tty/serial changes in it.
>
> I havn't see any respond for my v8 of this patch.
> https://lkml.org/lkml/2015/10/18/135
>
> Is it reviewed?

Can you send  v9 with Cc to me and Heikki?

My concerns here are a) to split refactor part (check LCR), and b) do
the actual feature enhancement.

-- 
With Best Regards,
Andy Shevchenko
