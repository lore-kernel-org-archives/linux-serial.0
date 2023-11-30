Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aizQFdJ3"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B53A10E3;
	Thu, 30 Nov 2023 05:09:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0odd57vhph70LwUuspLWUN/AdXzt83Wg6UVxFbHGAEFtXLPjZBGumQR/guzLIKfiX4rXRy4rDs2IQOLFRrjYyQVqEBqpnwt+TF0syc6NZOeEkWfYM+2yPAWYw+7Vmwt+V+6J+566nFME7k7pLH8UGkkOcVEMxa34P3uOOW0OcwkgpM83t8PWhYlgorHGaNiHtnmxSJQwBKuyjGO8pPUuByV+OatcSDjSIGlvXXqY6Gfm7cI0rka5J+63AeHekcu7lJ86JVjWB3iVtFlriKdDIW9C/N/H44DJjJ2siFx7pAjCtA8QvFL3BTGAA+Phjwg+qCNFDz+ufX75I0mJSkF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsOowVwC8UY6zr027r3jolDUsn/mY0YvPbe3bU2RY1c=;
 b=RifD8kR4ASsDhnRAjCW85drkz68bDtUdx/e8BA5FdNuwPXTGBtj6b31nRBhw39BjoisYi5iGEipRL7lKFYBEWzboRUvx3DF9jo6HaPvRtIhr7sxnKqUMAK2gOZ1POCDF60Y/owCUeKaRVzmsE2AoMRGL3ACsSpBk0lnyJCwPeZgEGTH2h6N+WELzXY/QmpgoSF5XPouYrIzmqolhdO2Kct+c8blMJy7mx6+BSQVmJCC99FZzoVeUTqz5P4nJI9FL7SkadO1jbmVxUhi5fyGbB8b9J4V3p5wbdCmz+q7O3F56KombM/mVgAHy7XbRaMgVFkvY6mMWygO/QM7y8AFVjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsOowVwC8UY6zr027r3jolDUsn/mY0YvPbe3bU2RY1c=;
 b=aizQFdJ3hinwnJFoPQuJPPo+mt0N4Uilm1eZpRcJyfR1zN4p+zeVcNDG5OYUVQfOW4t5IpmF4qfWoAewoWJkch9M5gS/OaKT+HBdYmNvaAuWlQAzWrBtMVJjYa+pejrUJCP4zf2sKfyMLeCBlqgsP6EA78NSPiT3vFw5CTHFmDGDh8DfdAwkTTxlsODgyXeNInzEfhkjSOP7i7SIbu5mdTHNQj+l40UvBikWsYmYHQfZZR+ZVC/oRHcIxoySl9TYx5OXFSwButBoorHwT3uqzbq2uUZwN3iGuA4aD1iFwpnmkXfTdH4HSAZT12tFgeKmvUm/1vK7ZwE+GBf7H2W5vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com (2603:10a6:208:16c::20)
 by DB9PR04MB9356.eurprd04.prod.outlook.com (2603:10a6:10:36a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.11; Thu, 30 Nov
 2023 13:09:51 +0000
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6]) by AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6%7]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 13:09:51 +0000
Message-ID: <7e649033-0e1d-4c21-a1f3-ceb2de894861@suse.com>
Date: Thu, 30 Nov 2023 14:09:48 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, USB list <linux-usb@vger.kernel.org>,
 linux-serial@vger.kernel.org
From: Oliver Neukum <oneukum@suse.com>
Subject: question on correct error return from break_ctl()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0386.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::14) To AM0PR04MB6467.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::20)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6467:EE_|DB9PR04MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f862ec5-fa9d-413c-6260-08dbf1a5a2f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CRBaGE4rSqR1yV+pR5lmi7/wwBbUIBbKuSYH0nU3AvEatmdjBAhkn6bntuI5H9pxCbpVjxq/QqdtZARHRYCiW3OFg79rdJnmSvmFdPkE5txfj44EDCvBrrL05Gq6Y0EAK+0xwI5nMz9y4YkSLFDPT97sciEvoJiJh/hs1+9W+yRIE/6/QInaq40/uPmuGs51uYzWHDo9U8pVkf1Gxy7plu4umZ1IBwgGbWwAr0jMoWMUNWTJSdysKS4sVfJUsoqswGKzJilLaM6XH70ItQCnrnf+T1Q3/R846U3wKK2/bh312af0MAJKIX0HWaQvYilAZq/nYxAfNwceHzBxeJ22yHZR5PXMfmfIc9mxj5Majl73rDnnoAnuHEenF4Jjcak9DQJuy8MLAfiRaSiY8xLF0BiJFryJBOAI9WJFHtVEcsutyye1ysRmxlbq3I3lNKsMPqbwXSYvWSGCmNVZY6X9DIzf2wezZqoLPilb2rhLEOD+0nbRuxR+GeIXqor6f3u1M1rRtNRPKBaSBcTDWh25wPFfagmKPbjNmFWHlQgKCUgEgA2RzDaMXYKOO0lc3IrBrvqNG4MdUH0ZRkL2LNApWr1FRrF+iF4Nm0/H/jGiVbpxICguAkZJvEa4BrgmBQck6AQt3Tzj7vSA0grVtudxfQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6467.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38100700002)(5660300002)(6506007)(2616005)(6916009)(6512007)(4744005)(2906002)(66556008)(66946007)(66476007)(478600001)(4326008)(54906003)(6666004)(316002)(6486002)(8676002)(8936002)(36756003)(86362001)(31696002)(41300700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0dCYkpEV0lOQmJkK05GYUtmOHQ4eE05SW42cG1SMVk0dm81clRWeUkwM0R1?=
 =?utf-8?B?Zzl6eVUzM1dzYkt6NDNMY1lBL3k1OHVLSEpUTGNpLzJ6UXJBN3hTalVtMHRE?=
 =?utf-8?B?dytPZEF3bldUM0F5WkxRZ0twN05GbHdaZ1B2YjVHdSt2Y3dBTFVtVVg5ZGNW?=
 =?utf-8?B?WnJVOFpSU2pvRXFJYk12YXFsbnpyUWdDM0R2TFEwaTRMWEhKVzVLakVGUXF2?=
 =?utf-8?B?cDZHaUgzV2ZBTmx4a1VzYlNuR0V5ZjM2eGR4VmFlM1dWYTNMTklSUHFHb1FY?=
 =?utf-8?B?L1NkdDVxY2VxQ3lLR3VzQUpkWXg1YXg0UnIxakxyRVBCUHRQdzZkT0lXbGRs?=
 =?utf-8?B?R1RKcjNZdlB5S2dXNC9HZ1lyYXhyZ3ZwZ2xQeDBvRis5VTByQU10aStHeVZl?=
 =?utf-8?B?ZGdWdE9BdndZdHF6MDFSeEcxOUowNTZJeHRQbklDNytLb240QWI1Mk1kRElq?=
 =?utf-8?B?aGdUYnVJUktMQmlWSzRFcW5rQ3lWUXY3TmhrK01iYnVxSmxrL0c3Um9VbGJ4?=
 =?utf-8?B?MU94V1FYaHZ6WjZJL2doZkp6THU0RkdBZ29xVDBibTZpUHRFbDJwT1IvVXU2?=
 =?utf-8?B?a0JIVm1WR0VtRWZrYzBIZVpjM1oybG1UOEJCNHQwdEh5emF1eVJIcHRLTUEz?=
 =?utf-8?B?b2loTE5hMHhNalgxbDZqZXJkNVA5OFpjUEVjTW5Xd2haYlJFZUF4QlZKMHgv?=
 =?utf-8?B?WmNPbVQxNXlEUnlQS0xmU01qNlVCZkw4alRSN2NiYm9Kb25MQWtvQ2NHVnRk?=
 =?utf-8?B?WDIrWElxTldlSWJZbmxxK3BCWXArWlpVbTBiY1JLN0JXTTQyUHp3amFCODJZ?=
 =?utf-8?B?eWlFMzlzZm5naklhTm1adGNVcHlYSXJxbjBGOXZ4cXhtdWhQVEp6Qm5TWFE3?=
 =?utf-8?B?WkpNdUFCMC9seTNRenluOEdJNDdYRnZOTWFkNHdmQ0d3ZVcvaHM2aFJsNDBo?=
 =?utf-8?B?TnhTZVdiZWsrM0NDUGJDeHp5dm1NdkR1NHY2S1VPbTFRT3lNeEtOOTZ5ODBn?=
 =?utf-8?B?b3NXRkNTZVdyWnJmQllMSnpOVHYvNDh4aDB6ZmtsVlA1bFgvdE1yNVM5cmF4?=
 =?utf-8?B?L2hxVFJLcy9zcERDWFdhVWM3NG1JTDlUNlFqSE5xT0ovWE16TjQ4Qm5oeXBM?=
 =?utf-8?B?d0diUlVUK2lsMnhlME5GdG95R2RuNkYxcmpRZTJDcGNzRDdWTVVKR1RDMlVl?=
 =?utf-8?B?bGxjSEJMbFBoK3lLZDJYWVZ6dGpWRTA4bFJQRUwrNmJ1dXJJU3MyQWlZMlpG?=
 =?utf-8?B?YzF4RkcwM2VoeG53d2NwSmJZSDhBbkVFYW5xbTNkbkthSXVXMjFVM1ZzTWp3?=
 =?utf-8?B?MzZXQWV1QzNtZzczM2I2aEgwSVZPSm5mcmd0ZW1uU2krbGtTV21MOEVyOVVw?=
 =?utf-8?B?TEFYNlVCQmxKaEpZUU1qYXZKL1pFbGRRQ2UwK2twa1hqdlBoWjlUSUJ3Vnk5?=
 =?utf-8?B?b29vY0pNTjNXQWZpUTJqcXpMYzR1MVJ3NS9KMVVoKzkzcWF2SDA5V09JZTIv?=
 =?utf-8?B?Y0wzVEZMYVkvZlJUSFNqQUhrR3lnN3FnQnVkdnlkb2YyRnh0UzFCVFpuTHIx?=
 =?utf-8?B?NDk3SndGWGJidkQ2VlNZb3ArMW5CU1VuKzJoY2tCWTh4dUNqV092cE45OXRQ?=
 =?utf-8?B?dTcvaUtrMGcyRnpDbTRLYVlGK28rd0pSYW82VVBlMjc4TWJRSW1velk2Tjgz?=
 =?utf-8?B?WmN4ZHRGaVZPVFRlSmxqczN2Z1FlaXBvSDVKNXA4dFkyeXI2cThNTFBodXcv?=
 =?utf-8?B?ZDVxalRjeDRzUlF0YW9mcTg2QTdCSGN1SXZScVhSWmhJUzNZMkZMc241RHp6?=
 =?utf-8?B?akorTUFxNnZZWlBCdjNaUDNneVZwMzVvUGJrTC9TaUlOMG40RjBkVlBkUFdX?=
 =?utf-8?B?bnRZVUwrRmIrK3FrVkdvS2k1MlBTNENOVEVhNXdIeUtEajdyckRBbmhDbnZF?=
 =?utf-8?B?M3V4ZzdSb0k1QkNLcnJWWXZvNC9nU2ozV3g2YkxGNDBCWFBadVpzTHlSLzlm?=
 =?utf-8?B?NHpsUHh5ZVhZWHM0ZEpyU0xsSXJzUU5wREtySUdzdkVRV0paOGNrSFNrQkps?=
 =?utf-8?B?MlEwcmszNlYzMW0xaWVpTG5vanExcWc2aFMyUkdwWnhUL1pETnRhZG9TQzl2?=
 =?utf-8?B?dHJHQnhMMlUrdldyakU5YVZ1Y29rT3kxdG9uODVCNEx1WmFRWjNUaDZKaEFT?=
 =?utf-8?Q?oEsI4TmQAeFW1fZIwhvvzge4B6DVW+fJQ+2b8l+LxCYc?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f862ec5-fa9d-413c-6260-08dbf1a5a2f7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6467.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 13:09:51.0499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvm043RQDl3sQZvNrRcpmiyWN8fuPG10a0+ik2E2jm4nQx1tv4TgnSHloFrOQRF27NHWwo/E01a+3j5wdvM8gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9356

Hi,

it seems inconsistent. The tty layer
in drivers/tty/tty_io.c::send_break()

static int send_break(struct tty_struct *tty, unsigned int duration)
{
         int retval;

         if (tty->ops->break_ctl == NULL)
                 return 0;

not supporting break_ctl() is treated as the operation
succeeding. Yet in drivers/usb/serial/usb-serial.c::serial_break()

static int serial_break(struct tty_struct *tty, int break_state)
{
         struct usb_serial_port *port = tty->driver_data;

         dev_dbg(&port->dev, "%s\n", __func__);

         if (port->serial->type->break_ctl)
                 return port->serial->type->break_ctl(tty, break_state);

         return -ENOTTY;
}

we are seeing that not supporting break_ctl() leads to returning
-ENOTTY, which drivers/tty/tty_io.c::send_break() will return to user space.
These reactions are at odds with each other. What is a driver supposed
to do?

	Regards
		Oliver
