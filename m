From: Pavel Andrianov <andrianov@ispras.ru>
Subject: A potential bug in drivers/tty/serial/jsm/jsm.ko
Date: Mon, 5 Sep 2016 12:11:07 +0300
Message-ID: <59b624dd-34b0-c130-77db-40db5802f03f@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Vaishali Thakkar <vaishali.thakkar@oracle.com>, ldv-project@linuxtesting.org
List-Id: linux-serial@vger.kernel.org

Hi!

There is a potential bug in drivers/tty/serial/jsm/jsm.ko.
In neo_parse_isr, line 764 a field ch->ch_flags is updated under 
spinlock protection. In neo_copy_data_from_uart_to_queue the same values 
are written to the field without any protection, as the function is 
always called without locks.
Should the same lock be used in these cases?
-- 
Pavel Andrianov
Linux Verification Center, ISPRAS
web: http://linuxtesting.org
e-mail: andrianov@ispras.ru
