From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] serial: samsung: fix the inconsistency in spinlock
Date: Thu, 18 Feb 2016 12:03:01 -0800
Message-ID: <56C62375.3070607@hurleysoftware.com>
References: <1455817202-3005-1-git-send-email-linux.amoon@gmail.com>
 <56C603E9.9050307@hurleysoftware.com>
 <CANAwSgQuo_V_6J4C6MgdiDFeTTGaTPzoONSUKXwcanCpCWtZSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CANAwSgQuo_V_6J4C6MgdiDFeTTGaTPzoONSUKXwcanCpCWtZSg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 02/18/2016 11:14 AM, Anand Moon wrote:
> Thanks for pointing out.
> Their is no lock up, just the inconstancy of the spin_lock.
> Then I will resend this patch dropping the spin_unlock/spin_lock
> around uart_write_wakeup.
> Is that ok with you.

Yes.
