From: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Subject: serial/pch_uart: AT command behavior
Date: Tue, 19 Jul 2011 13:15:57 +0900
Message-ID: <4E2504FD.6090107@dsn.okisemi.com>
References: <1308736219-19975-1-git-send-email-alexander.stein@systec-electronic.com> <4E02857C.1010304@dsn.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4E02857C.1010304@dsn.okisemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, "toshiharu-linux@dsn.okisemi.com" <toshiharu-linux@dsn.okisemi.com>, "Ewe, Kok Howg" <kok.howg.ewe@intel.com>, "Wang, Qi" <qi.wang@intel.com>, "Wang, Yong Y" <yong.y.wang@intel.com>, "Clark, Joel" <joel.clark@intel.com>
List-Id: linux-serial@vger.kernel.org

Hi,

I have a question for UART driver AT command behavior.
When installing pch_uart, AT command "AT+GCAP^M" are sent for 4 times.
This command is sent first install only.
(After the above, removing pch_uart and installing pch_uart again,
this command is not sent.)

Let me know the behavior is normal or not ?

Thanks,
-- 
tomoya
OKI SEMICONDUCTOR CO., LTD.
